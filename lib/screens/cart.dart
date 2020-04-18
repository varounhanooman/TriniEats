import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';
import 'package:trini_eats/models/merchantmenu.dart';

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
    // var newMap = groupBy(cartList.cart, (obj) => obj['name']);
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
            child: GroupedListView<MenuItems, String>(
              elements: cartList.cart,
              groupBy: (element) => element.merchant,
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),

                // TODO: Create checkout button where value = merchant
                // then create firestore function for each
                child: RaisedButton(
                  
                  child: Text('Checkout ' + value),
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                ),
              ),
              itemBuilder: (context, element) => ListTile(
                title: Text(element.name),
                subtitle: Text(FlutterMoneyFormatter(amount: element.price.toDouble()).output.symbolOnLeft),
                trailing: IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    cartList.removeFromCart(element);
                  },
                ),
              ),
              order: GroupedListOrder.DESC,
            ),
          ),
        ],
      ),
    );
  }
}
