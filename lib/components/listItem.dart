import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Veggie Delight', style: TextStyle(color: Colors.black, fontSize: 18.0),),
          Text('Comes with freshly sliced cruchy salad.', style: TextStyle(color: Colors.grey, fontSize: 16.0),),
          Row(
            children: <Widget>[
              Container(
                child: Text('\$23.00'),
              ),
              Container(
                child: Icon(Icons.star, size: 18, color: Colors.orangeAccent,),
              ),
              Container(
                child: Text('Popular', style: TextStyle(color: Colors.orangeAccent),),
              )
            ],
          )
        ],
      ),
    );
  }
}
