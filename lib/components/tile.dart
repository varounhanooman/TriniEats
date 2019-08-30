import 'package:flutter/material.dart';
import '../pages/details.dart';

class Tile extends StatelessWidget {
  const Tile({Key key, this.image}) : super(key: key);

  final Image image;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              height: 80,
              width: 80,
              // color: Colors.grey,
              child: image,
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details()),
        );
      },
      padding: EdgeInsets.only(right: 10.0),
    );
  }
}
