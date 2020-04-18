import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';
import 'package:trini_eats/models/merchantmenu.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartList = Provider.of<MerchantBloc>(context);
    List<MenuItems> cart = [];
    cartList.cart.forEach((item) {
      if (item.merchant.contains('KFC')) {
        cart.add(item);
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
              itemCount: cart.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(cart[index].name),
                  subtitle: Text(cart[index].merchant),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text('Pickup'),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text('Delivery'),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 20.0,)
        ],
      ),
    );
  }
}
