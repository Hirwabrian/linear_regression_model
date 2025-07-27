import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'pages/form_page.dart';
import 'pages/result_page.dart';

void main() {
  runApp(SchoolCompletionApp());
}

class SchoolCompletionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Completion Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.orange.shade50,
        textTheme: Typography.blackCupertino,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/form': (context) => PredictionFormPage(),
        '/result': (context) => ResultPage(),
      },
    );
  }
}
