import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

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
            // List
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Product(
                      title: 'Monday Meal',
                      group: 'Subway',
                      image: Image.asset(
                        'assets/products/daymeal.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Product(
                      title: '5 Flavour Meal',
                      group: 'Pizza Hut',
                      image: Image.asset(
                        'assets/products/5flavour.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Product(
                      title: 'Grand Opening',
                      group: 'Pizza Hut',
                      image: Image.asset(
                        'assets/products/Couva.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Product(
                      title: 'Big Meal',
                      group: 'KFC',
                      image: Image.asset(
                        'assets/products/KFCMeal.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Product(
                      title: 'Ultimate Box',
                      group: 'Pizza Boys',
                      image: Image.asset(
                        'assets/products/UltimateBox.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Test() {
    print('hello');
  }
}
