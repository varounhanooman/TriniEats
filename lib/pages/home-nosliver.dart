import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/tile.dart';
import '../components/rectangle.dart';
import '../components/product.dart';

import 'package:flutter/foundation.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Trini Eats',
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.start,
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("Category").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categoryFirestore(snapshot),
                    ),
                  );
                },
              ),
            ),
            Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      Firestore.instance.collection("Promotions").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: ListView(children: promotionFirestore(snapshot)),
                    );
                  },
                ),
            ),
          ],
        ));
  }

  promotionFirestore(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new Product(
              title: doc["Title"],
              company: doc["Company"],
              image: Image.network(
                doc["Image"],
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }

  categoryFirestore(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new Tile(
              image: Image.network(
                doc["Image"],
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }
}
