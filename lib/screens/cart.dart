import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var cartList = Provider.of<MerchantBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: ListView.builder(
          itemCount: cartList.cart.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(cartList.cart[i].toString()),
            );
          },
        ));
  }
}
