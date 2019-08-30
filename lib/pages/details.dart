import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../components/listItem.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

SliverPersistentHeader makeHeader(String headerText) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: _SliverAppBarDelegate(
      minHeight: 40.0,
      maxHeight: 40.0,
      child: Container(
          color: Colors.grey[200], child: Center(child: Text(headerText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),))),
    ),
  );
}

class Details extends StatelessWidget {
  const Details({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subway'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/products/daymeal.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 0.0, top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  'Subway - Arouca',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 15.0,
                                ),
                                Text('4.3'),
                                Text(' - Sandwiches, American'),
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
          makeHeader('6" Subs'),
          SliverFixedExtentList(
            itemExtent: 80.0,
            delegate: SliverChildListDelegate(
              [
                Item(),
                Item(),
                Item(),
                Item(),
                Item(),
              ],
            ),
          ),
          makeHeader('12" Subs'),
          SliverFixedExtentList(
            itemExtent: 80.0,
            delegate: SliverChildListDelegate(
              [
                Item(),
                Item(),
                Item(),
                Item(),
                Item(),
              ],
            ),
          ),
          makeHeader('Signature Wraps'),
          SliverFixedExtentList(
            itemExtent: 80.0,
            delegate: SliverChildListDelegate(
              [
                Item(),
                Item(),
                Item(),
                Item(),
                Item(),
              ],
            ),
          ),
          makeHeader('Salads'),
          SliverFixedExtentList(
            itemExtent: 80.0,
            delegate: SliverChildListDelegate(
              [
                Item(),
                Item(),
                Item(),
                Item(),
                Item(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
