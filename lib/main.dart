import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/router.dart';

import 'bloc/_providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trini Eats',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
