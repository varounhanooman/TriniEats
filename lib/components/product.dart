import 'package:flutter/material.dart';
import '../pages/details.dart';

class Product extends StatelessWidget {
  const Product({Key key, this.image, this.title, this.menu})
      : super(key: key);

  final Widget image;
  final String title;
  final Map menu;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(title: title, menu: menu,)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  // color: Colors.grey,
                  child: image,
                ),
              ),
              // Positioned(
              //   right: 10,
              //   bottom: 10,
              //   child: ClipRRect(
              //     borderRadius: new BorderRadius.circular(20.0),
              //     child: Container(
              //       child: Column(
              //         children: <Widget>[Text('Around'), Text('40 mins')],
              //       ),
              //       height: 40,
              //       width: 80,
              //       color: Color(0xFFEAE8E8),
              //     ),
              //   ),
              // )
            ],
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          // Text(company),
          Container(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
