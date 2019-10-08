import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key key, this.userLoc}) : super(key: key);
  final String userLoc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Text(userLoc),
      ),
    );
  }
}
