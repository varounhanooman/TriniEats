import 'package:flutter/material.dart';
// import '../pages/details.dart';

class Rectangle extends StatelessWidget {
  const Rectangle({Key key, this.image}) : super(key: key);

  final Image image;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(right: 10.0, left: 0.0),
      onPressed: () {
        //  Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Details()),
        // );
      },
      child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(5.0),
              child: Container(
                height: 100,
                width: 180,
                // color: Colors.grey,
                child: image,
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(20.0),
                child: Container(
                  child: Column(
                    children: <Widget>[Text('Around'), Text('40 mins')],
                  ),
                  height: 40,
                  width: 80,
                  color: Color(0xFFEAE8E8),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
