import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './details.dart';

class QueryFilter extends StatefulWidget {
  QueryFilter({Key key, this.name}) : super(key: key);
  final String name;

  _QueryState createState() => _QueryState();
}

class _QueryState extends State<QueryFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Container(
            margin: EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("Merchant")
                    .where('Display', isEqualTo: true)
                    .where('Tags', arrayContains: widget.name.toLowerCase())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  return ListView.builder(
                    itemCount:
                        snapshot.hasData ? snapshot.data.documents.length : 0,
                    itemBuilder: (context, index) {
                      return Card(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                        title: snapshot.data.documents[index]
                                            ['Name'],
                                        docId: snapshot
                                            .data.documents[index].documentID
                                            .toString(),
                                        image: FadeInImage.assetNetwork(
                                          fadeInCurve: Curves.easeIn,
                                          placeholder: 'assets/placeholder.png',
                                          image: snapshot.data.documents[index]
                                              ['Image'],
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                            );
                          },
                          child: ListTile(
                            title: Text(snapshot.data.documents[index]['Name']),
                            leading: FadeInImage.assetNetwork(
                              fadeInCurve: Curves.easeIn,
                              placeholder: 'assets/placeholder.png',
                              image: snapshot.data.documents[index]['Image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                })));
  }
}
