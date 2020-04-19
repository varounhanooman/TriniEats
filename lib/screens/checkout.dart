import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/auth_bloc.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';
import 'package:trini_eats/models/merchantmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatelessWidget {
  @required
  final String merc;
  const Checkout(this.merc);

  @override
  Widget build(BuildContext context) {
    var merchantBloc = Provider.of<MerchantBloc>(context);
    var userBloc = Provider.of<AuthBloc>(context);
    double cartTotal = 0.00;
    List<MenuItems> displayCart = [];
    List cart = [];
    merchantBloc.cart.forEach((item) {
      if (item.merchant.contains(merc)) {
        cart.add(item.toJson());
        displayCart.add(item);
        cartTotal += item.price;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Merchant Checkout'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: displayCart.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(displayCart[index].name),
                  subtitle: Text(displayCart[index].merchant),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text('Pickup'),
                onPressed: () {
                  _placeOrderPickup(userBloc.user, cart, cartTotal);
                },
              ),
              RaisedButton(
                child: Text('Delivery'),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }

  void _placeOrderPickup(FirebaseUser user, List items, double total) async {
    return await Firestore.instance
        .collection('Merchant')
        .document(merc)
        .collection('orders')
        .document()
        .setData({
      'customer_name': user.displayName,
      'customer_id': user.uid,
      'customer_email': user.email,
      'order_time': DateTime.now(),
      'items': items,//[{'a':'v','b':99.00,'c':[1,2,3]},{'a':'v','b':99.00,'c':[1,2,3]}],
      'total': total.toDouble(),
      'order_type': 'pick-up',
      'status': 'waiting',
      'status_description': 'waiting for confirmation'
    }).then((onValue) {
      print('Done');
    }).catchError((e) {
      print('======Error======== ' + e);
    });
  }
}
