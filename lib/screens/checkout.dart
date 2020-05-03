import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/auth_bloc.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';
import 'package:trini_eats/models/merchantmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

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
    var uuid = Uuid();
    String checkoutID = uuid.v1().toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout - ' +
            FlutterMoneyFormatter(amount: cartTotal).output.symbolOnLeft),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: displayCart.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(displayCart[index].name),
                  subtitle: Text(FlutterMoneyFormatter(
                          amount: displayCart[index].price.toDouble())
                      .output
                      .symbolOnLeft),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text('Pickup'),
                onPressed: () async {
                  await _addToMyOrders(
                      userBloc.user, cart, cartTotal, 'pick-up', checkoutID);
                  await _placeOrderPickup(
                          userBloc.user, cart, cartTotal, 'pick-up', checkoutID)
                      .then((onValue) {
                    displayCart
                        .forEach((item) => merchantBloc.removeFromCart(item));
                    Navigator.pop(context);
                  });
                },
              ),
              RaisedButton(
                child: Text('Delivery'),
                onPressed: () async {
                  await _addToMyOrders(
                      userBloc.user, cart, cartTotal, 'delivery', checkoutID);
                  await _placeOrderPickup(userBloc.user, cart, cartTotal,
                          'delivery', checkoutID)
                      .then((onValue) {
                    displayCart
                        .forEach((item) => merchantBloc.removeFromCart(item));
                    Navigator.pop(context);
                  });
                },
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

  Future _placeOrderPickup(FirebaseUser user, List items, double total,
      String type, String uuid) async {
    return await Firestore.instance
        .collection('Merchant')
        .document(merc)
        .collection('orders')
        .document(uuid)
        .setData({
      'id': uuid,
      'customer_name': user.displayName,
      'customer_id': user.uid,
      'customer_email': user.email,
      'order_time': DateTime.now(),
      'items': items,
      'total': total.toDouble(),
      'order_type': type,
      'status': 'waiting',
      'status_description': 'waiting for confirmation'
    }).then((onValue) {
      Fluttertoast.showToast(msg: 'Order Processed!');
      print('Done');
    }).catchError((e) {
      Fluttertoast.showToast(msg: 'Error ' + e);
      print('======Error======== ' + e);
    });
  }

  Future _addToMyOrders(FirebaseUser user, List items, double total,
      String type, String uuid) async {
    return await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .collection('waiting')
        .document(uuid)
        .setData({
      'id': uuid,
      'customer_name': user.displayName,
      'customer_id': user.uid,
      'customer_email': user.email,
      'order_time': DateTime.now(),
      'items': items,
      'total': total.toDouble(),
      'order_type': type,
      'merchant': merc,
      'status': 'waiting',
      'status_description': 'waiting for confirmation'
    }).then((onValue) {
      Fluttertoast.showToast(msg: 'Order Processed!');
      print('Done');
    }).catchError((e) {
      Fluttertoast.showToast(msg: 'Error ' + e);
      print('======Error======== ' + e);
    });
  }
}
