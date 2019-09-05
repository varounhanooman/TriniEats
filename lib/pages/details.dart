import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../components/listItem.dart';

class Menu {
  final String title;
  final String details;
  final double price;
  final List items;

  Menu(this.title, this.details, this.price, this.items);

  factory Menu.fromJson(Map<String, dynamic> parsedJson){
    return Menu(
      title: parsedJson['title'],
      details: parsedJson['details'],
      price: parsedJson['price'],
      items: parsedJson['items']
    );
  }
}


class Details extends StatelessWidget {
  const Details({Key key, this.title, this.menu}) : super(key: key);

  final Map menu;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(menu.toString()),
        ));
  }
}
