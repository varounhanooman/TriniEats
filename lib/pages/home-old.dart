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
      body: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, bottom: 0.0, top: 10.0),
        child: CustomScrollView(
          slivers: <Widget>[
            //Top Row
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
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
                                labelText: 'Dishes, restaruants and cuisines'),
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
            ),
            // TileSection
            /****************************** CATEGORIES   ****************/
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Tile(image: Image.asset('assets/categories/kfc.png')),
                      Tile(
                          image:
                              Image.asset('assets/categories/PizzaBoys.jpg')),
                      Tile(
                          image:
                              Image.asset('assets/categories/PizzaHut.jpeg')),
                      Tile(image: Image.asset('assets/categories/Subway.png')),
                      Tile(
                          image:
                              Image.asset('assets/categories/RoyalCastle.jpg')),
                    ],
                  )),
            ),
            // Title
            //***************************    TOP RATED   *****************************/
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('Top Rated'),
                ),
              ]),
            ),
            // Top Rated Section
            SliverToBoxAdapter(
              child: Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Rectangle(
                          image: Image.asset('assets/top_rated/BigDeal.png')),
                      Rectangle(
                          image:
                              Image.asset('assets/top_rated/DoubleDeal.png')),
                      Rectangle(
                          image: Image.asset(
                              'assets/top_rated/GoldenNuggets.jpg')),
                      Rectangle(
                          image:
                              Image.asset('assets/top_rated/RoyalWings.jpg')),
                    ],
                  )),
            ),
            SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('hello')
                      ),
                    ],
                  ),
                ),
            // List
            // StreamBuilder<QuerySnapshot>(
            //   stream: Firestore.instance.collection("Promotions").snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) return CircularProgressIndicator();
            //     return Text('Ho Ho');
            //   }
            // ),
          ],
        ),
      ),
    );
  }

  // productFirestore(AsyncSnapshot<QuerySnapshot> snapshot) {
  //   return snapshot.data.documents
  //       .map((doc) => Product(
  //             title: doc["Title"],
  //             company: doc["Company"],
  //             image: Image.network(doc["Image"]),
  //           ))
  //       .toList();
  // }
}
