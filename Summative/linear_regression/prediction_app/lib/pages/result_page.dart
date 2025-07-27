import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double probability =
        ModalRoute.of(context)!.settings.arguments as double;
    final percent = (probability * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(title: Text("Prediction Result")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 80, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Estimated Probability of Completion:",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "$percent%",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Try Again"),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
