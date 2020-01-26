import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({Key key, this.image, this.title, this.docId})
      : super(key: key);

  final Widget image;
  final String title;
  @required final String docId;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(10.0),
      onPressed: () {
        Navigator.pushNamed(context, '/menu', arguments: docId);
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
