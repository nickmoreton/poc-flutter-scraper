import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate Docs Summary',
      home: const HomeScreen(),
    );
  }
}
