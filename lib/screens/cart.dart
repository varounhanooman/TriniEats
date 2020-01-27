import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String cartTotal;
  @override
  Widget build(BuildContext context) {
    var cartList = Provider.of<MerchantBloc>(context);
    cartTotal = FlutterMoneyFormatter(amount: cartList.cartTotal.toDouble())
        .output
        .symbolOnLeft;
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Total: ' + cartTotal,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartList.cart.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(cartList.cart[i].name),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        cartList.removeFromCart(cartList.cart[i]);
                      },
                    ),
                  );
                },
              ),
            ),
            RaisedButton(
              child: Text('CHECKOUT'),
              onPressed: () {},
            )
          ],
        ));
  }
}
