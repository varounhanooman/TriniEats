import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/tile.dart';
import '../components/product.dart';

import './login.dart';
import './map.dart';
// import 'package:flutter/foundation.dart';

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
        body: CustomScrollView(
          slivers: <Widget>[
            // //Top Row
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Deliver now'),
                                  Text(
                                    'Select Location',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              color: Colors.blue,
                              icon: Icon(Icons.account_circle),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelText:
                                          'Dishes, restaruants and cuisines'),
                                ),
                              ),
                            ),
                            IconButton(
                              color: Colors.blue,
                              icon: Icon(Icons.pin_drop),
                              iconSize: 30.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Maps()),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("Category")
                      .orderBy("Order")
                      .snapshots(),
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
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 30.0,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Restaurants',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(15.0),
              sliver: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("Promotions")
                      .where('Display', isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: <Widget>[
                            Text(snapshot.data.documents[index]['Time']
                                .toString()),
                            Product(
                              title: snapshot.data.documents[index]['Title'],
                              company: snapshot.data.documents[index]
                                  ['Company'],
                              image: FadeInImage.assetNetwork(
                                fadeInCurve: Curves.easeIn,
                                placeholder: 'assets/placeholder.png',
                                image: snapshot.data.documents[index]['Image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      },
                      childCount:
                          snapshot.hasData ? snapshot.data.documents.length : 0,
                    ));
                  }),
            ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     padding: EdgeInsets.only(left: 15.0, right: 15.0),
            //     child: Row(
            //       children: <Widget>[
            //         Icon(
            //           Icons.cake,
            //           size: 30.0,
            //         ),
            //         Container(
            //           child: Align(
            //             alignment: Alignment.centerLeft,
            //             child: Text(
            //               'Eats',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold, fontSize: 30.0),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ));
  }

  categoryFirestore(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new Tile(
              name: doc['Name'],
              image: FadeInImage.assetNetwork(
                fadeInCurve: Curves.easeIn,
                placeholder: 'assets/placeholder.png',
                image: doc['Image'],
                fit: BoxFit.fill,
              ),
            ))
        .toList();
  }
}
