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
                            CircleAvatar(
                              backgroundColor: Colors.grey,
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
                              color: Colors.grey,
                              icon: Icon(Icons.filter_list),
                              iconSize: 30.0,
                              onPressed: () {},
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
            ),
            SliverPadding(
              padding: EdgeInsets.all(15.0),
              sliver: StreamBuilder(
                  stream:
                      Firestore.instance.collection("Promotions").snapshots(),
                  builder: (context, snapshot) => SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) => Product(
                          title: snapshot.data.documents[index]['Title'],
                          company: snapshot.data.documents[index]['Company'],
                          image: Image.network(
                            snapshot.data.documents[index]['Image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        childCount: snapshot.data.documents.length,
                      ))),
            ),
          ],
        ));
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
