import 'package:flutter/material.dart';
import './pages/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trini Eats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Test()
    );
  }
}