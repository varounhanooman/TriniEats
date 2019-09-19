import 'package:flutter/material.dart';
import '../pages/query.dart';

class Tile extends StatelessWidget {
  const Tile({Key key, this.name, this.image}) : super(key: key);

  final Widget image;
  final String name;

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
          Positioned(
              bottom: 5,
              left: 5,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 8.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              )),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QueryFilter(name: name,)),
        );
      },
      padding: EdgeInsets.only(right: 10.0),
    );
  }
}
