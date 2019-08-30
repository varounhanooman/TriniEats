import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatelessWidget {
  const Test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: FireData(),
        ));
  }
}

class FireData extends StatelessWidget {
  const FireData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Promotions").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('no data');
        return ListView(
          children: sumName(snapshot),
        );
      },
    );
  }

  sumName(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new ListTile(
              title: Text(doc["Title"]),
              subtitle: Text(doc["Company"]),
              leading: Image.network(doc["Image"]),
            ))
        .toList();
  }
}
