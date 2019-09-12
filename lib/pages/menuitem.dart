import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({Key key, this.image, this.items, this.name, this.price})
      : super(key: key);
  final String name;
  final num price;
  final List items;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(name),
              background: image,
            ),
          )
        ];
      },
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      name,
                      style: TextStyle(fontSize: 20.0),
                    )),
                    Text('\$',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                    Text(
                      price.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
