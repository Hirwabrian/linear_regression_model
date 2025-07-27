import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/form');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_graph, size: 80, color: Colors.deepOrange),
            SizedBox(height: 20),
            Text(
              "Predicting Possibility",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Education. Inequality. Data."),
          ],
        ),
      ),
    );
  }
}
