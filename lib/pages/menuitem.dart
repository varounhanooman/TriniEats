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
              background: Opacity(opacity: 0.7, child: image),
            ),
          )
        ];
      },
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: ListView(
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
            Card(
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Ingredients',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Text(items[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('1'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: RaisedButton(child: Text('Add to Cart'), onPressed: (){},),
            )
            // Container(
            //   margin: EdgeInsets.only(left: 50, right: 50, top: 20),
            //   child: Row(
            //     children: <Widget>[
            //       FloatingActionButton(
            //         child: Icon(Icons.remove),
            //         onPressed: () {},
            //       ),
            //       Expanded(
            //           child: Center(
            //         child: Text('1'),
            //       )),
            //       FloatingActionButton(
            //         child: Icon(Icons.add),
            //         onPressed: () {},
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}
