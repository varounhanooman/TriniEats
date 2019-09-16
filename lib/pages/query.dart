import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Query extends StatefulWidget {
  Query({Key key, this.name}) : super(key: key);
  final String name;

  _QueryState createState() => _QueryState();
}

class _QueryState extends State<Query> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Center(
            child: MaterialButton(
          child: Text('Press'),
          onPressed: getData,
        )));
  }

  void getData() {
    Firestore.instance
        .collectionGroup('menu')
        .where('Items', arrayContains: '1 Large Drink')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        print();
      });
    });
  }
}
