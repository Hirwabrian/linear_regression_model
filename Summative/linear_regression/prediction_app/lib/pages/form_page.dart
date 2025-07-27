import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/loading_page.dart';
import 'dart:convert';

class PredictionFormPage extends StatefulWidget {
  @override
  _PredictionFormPageState createState() => _PredictionFormPageState();
}

class _PredictionFormPageState extends State<PredictionFormPage> {
  final _formKey = GlobalKey<FormState>();
  double age = 16;
  int sex = 1;
  int urban = 1;
  int region = 0;
  int wealth = 2;
  String? errorMsg;

  Future<void> _predict() async {
    final url = Uri.parse(
      "https://school-completion-prediction-lwfu.onrender.com/predict",
    );

    // Navigate to the themed loading screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoadingPage(message: "Sending data to the model..."),
      ),
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'age': age,
          'sex': sex,
          'urban': urban,
          'region': region,
          'wealth': wealth,
        }),
      );

      Navigator.pop(context); // Close loading screen

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        double probability = result["completion_probability"];
        Navigator.pushNamed(context, '/result', arguments: probability);
      } else {
        setState(() => errorMsg = "Server error. Check your inputs.");
      }
    } catch (e) {
      Navigator.pop(context); // Close loading screen
      setState(() => errorMsg = "Could not connect. Try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("School Completion Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Enter details to predict completion:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(labelText: "Age (10-25)"),
                initialValue: "16",
                keyboardType: TextInputType.number,
                onChanged: (val) => age = double.tryParse(val) ?? 16,
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: "Sex"),
                value: sex,
                items: [
                  DropdownMenuItem(child: Text("Female"), value: 1),
                  DropdownMenuItem(
                    child: Text("Male (not in training set)"),
                    value: 0,
                  ),
                ],
                onChanged: (val) => setState(() => sex = val ?? 1),
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: "Urban or Rural"),
                value: urban,
                items: [
                  DropdownMenuItem(child: Text("Urban"), value: 1),
                  DropdownMenuItem(child: Text("Rural"), value: 0),
                ],
                onChanged: (val) => setState(() => urban = val ?? 1),
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: "Region (0–9)"),
                value: region,
                items: List.generate(
                  10,
                  (i) => DropdownMenuItem(child: Text("Region $i"), value: i),
                ),
                onChanged: (val) => setState(() => region = val ?? 0),
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: "Wealth Index"),
                value: wealth,
                items: [
                  DropdownMenuItem(child: Text("Poorest"), value: 0),
                  DropdownMenuItem(child: Text("Poorer"), value: 1),
                  DropdownMenuItem(child: Text("Middle"), value: 2),
                  DropdownMenuItem(child: Text("Richer"), value: 3),
                  DropdownMenuItem(child: Text("Richest"), value: 4),
                ],
                onChanged: (val) => setState(() => wealth = val ?? 2),
              ),
              SizedBox(height: 20),
              ElevatedButton(child: Text("Predict"), onPressed: _predict),
              if (errorMsg != null) ...[
                SizedBox(height: 16),
                Text(errorMsg!, style: TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
