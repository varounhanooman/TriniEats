// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:trini_eats/components/categories.dart';

// class CategoryList extends StatelessWidget {
//   final List<Category> category;
//   CategoryList({Key key, this.category}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//         itemCount: category == null ? 0 : category.length,
//         itemBuilder: (BuildContext context, int index) {
//           return
//                 new Card(
//                   child: new Container(
//                     child: new Center(
//                         child: new Column(
//                       // Stretch the cards in horizontal axis
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget>[

//                         new Text(
//                           // Read the name field value and set it in the Text widget
//                           category[index].name,
//                           // set some style to text
//                           style: new TextStyle(
//                               fontSize: 20.0, color: Colors.lightBlueAccent),
//                         ),
//                         new Text(
//                           // Read the name field value and set it in the Text widget
//                           "Capital:- " + category[index].capital,
//                           // set some style to text
//                           style: new TextStyle(
//                               fontSize: 20.0, color: Colors.amber),
//                         ),
//                       ],
//                     )),
//                     padding: const EdgeInsets.all(15.0),
//                   ),
//              );
//         });
//     }
// }