import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/auth_bloc.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';
import 'package:trini_eats/models/cart_model.dart';
import 'package:trini_eats/models/merchantmenu.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String cartTotal;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthBloc>(context).user;
    var path = Firestore.instance
        .collection('Users')
        .document(user.uid)
        .collection('waiting');
    // cartTotal = FlutterMoneyFormatter(amount: cartList.cartTotal.toDouble())
    //     .output
    //     .symbolOnLeft;
    // var newMap = groupBy(cartList.cart, (obj) => obj['name']);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('My Orders'),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: 'Waiting',
                  icon: Icon(Icons.timer),
                ),
                Tab(
                  text: 'In Progress',
                  icon: Icon(Icons.directions_run),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              StreamBuilder(
                stream: path.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'No Data...',
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data.documents[index]['merchant']),
                              subtitle:
                                  Text(snapshot.data.documents[index]['status_description']),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          );
                        });
                  }
                },
              ),
              Text('fulfil')
            ],
          )
          // Column(
          //   children: <Widget>[
          //     Expanded(
          //       child: GroupedListView<MenuItems, String>(
          //         elements: cartList.cart,
          //         groupBy: (element) => element.merchant,
          //         groupSeparatorBuilder: (String value) => Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: RaisedButton(
          //             child: Text('Checkout ' + value),
          //             onPressed: () {
          //               Navigator.pushNamed(context, '/checkout',
          //                   arguments: value);
          //             },
          //           ),
          //         ),
          //         itemBuilder: (context, element) => ListTile(
          //           title: Text(element.name),
          //           subtitle: Text(
          //               FlutterMoneyFormatter(amount: element.price.toDouble())
          //                   .output
          //                   .symbolOnLeft),
          //           trailing: IconButton(
          //             icon: Icon(
          //               Icons.remove_circle_outline,
          //             ),
          //             color: Colors.red,
          //             onPressed: () {
          //               cartList.removeFromCart(element);
          //             },
          //           ),
          //         ),
          //         order: GroupedListOrder.DESC,
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
