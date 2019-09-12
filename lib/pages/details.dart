import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import './menuitem.dart';

class Menu {
  String title;
  String details;
  int price;
  String items;

  Menu(Map<String, dynamic> data) {
    title = data['title'];
    details = data['details'];
    price = data['price'];
    items = data[items];
  }
}

class Details extends StatelessWidget {
  const Details({Key key, this.title, this.docId, this.image})
      : super(key: key);

  final String docId;
  final String title;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    // var data = json.decode(json.encode(menu));
    // var items = Menu(data);
    // print('${items.items}');
    // print(image);
    return Scaffold(
        appBar: AppBar(
          title: Text(docId),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("Merchant")
                .document(docId)
                .collection('menu')
                .snapshots(),
            builder: (context, snapshot) {
              // print(snapshot.data.documents[0].documentID);
              print(snapshot.hasData);
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              return ListView.builder(
                itemCount:
                    snapshot.hasData ? snapshot.data.documents.length : 0,
                itemBuilder: (context, index) {
                  var collection = snapshot.data.documents[index].data;
                  // print(collection);
                  var items = MenuItems.fromJson(collection);
                  if (snapshot.hasData) {
                    return Card(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Item(
                                    name: items.name,
                                    price: items.price,
                                    items: items.items,
                                    image: items.image)),
                          );
                        },
                        child: ListTile(
                          // leading: Image.network(snapshot.data.documents[index]['Image']),
                          leading: items.image,
                          title: Text(items.name),
                          subtitle: Text(items.items.toString()),
                          trailing: Text(items.price.toStringAsFixed(2)),
                          // dense: true,
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('no data'));
                  }
                },
              );
            }));
  }
}

Widget getTextWidgets(List<String> strings) {
  return new Row(children: strings.map((item) => new Text(item)).toList());
}

class MenuItems {
  String name;
  String category;
  num price;
  List items;
  Widget image;

  MenuItems({this.category, this.image, this.items, this.price, this.name});
  MenuItems.fromJson(Map<String, dynamic> data)
      : name = data['Name'],
        category = data['Category'],
        price = data['Price'],
        items = data['Items'],
        image = FadeInImage.assetNetwork(
          fadeInCurve: Curves.easeIn,
          placeholder: 'assets/placeholder.png',
          image: data['Image'],
          fit: BoxFit.cover,
        );
}
