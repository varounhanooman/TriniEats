import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/listItem.dart';

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
                  // var collection = snapshot.data.documents[index].data;
                  // print(collection);
                  if (snapshot.hasData) {
                    return Card(
                      child: FlatButton(
                        onPressed: (){},
                        child: ListTile(
                          // leading: Image.network(snapshot.data.documents[index]['Image']),
                          leading: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.easeIn,
                                  placeholder: 'assets/placeholder.png',
                                  image: snapshot.data.documents[index]['Image'].toString(),
                                  fit: BoxFit.cover,
                                ),
                          title: Text(snapshot.data.documents[index]['Name'].toString()),
                          subtitle: Text(snapshot.data.documents[index]['Items'].toString()),
                          trailing: Text(snapshot.data.documents[index]['Price'].toString()),
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
