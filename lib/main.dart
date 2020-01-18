import 'package:flutter/material.dart';
import 'package:trini_eats/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trini Eats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Auth(),
    );
  }
}
