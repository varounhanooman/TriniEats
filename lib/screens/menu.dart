import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';
import 'package:trini_eats/models/merchantmenu.dart';
import 'package:badges/badges.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class Menu extends StatefulWidget {
  @required
  final String docID;
  Menu(this.docID);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future _getMenu;
  FlutterMoneyFormatter fmf;
  @override
  void initState() {
    super.initState();
    _getMenu = Future.microtask(() =>
        Provider.of<MerchantBloc>(context, listen: false)
            .getMenuItems(widget.docID));
  }

  Widget _menuList(MerchantBloc merchant) {
    MerchantMenu menuItems = merchant.allMenu;
    return SliverList(
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          fmf = FlutterMoneyFormatter(
              amount: double.parse(menuItems.menuItems[index].price));
          return Container(
            height: 150,
            child: Card(
              semanticContainer: true,
              child: ListTile(
                onTap: () {
                  merchant.setCart(menuItems.menuItems[index].id);
                },
                title: Text(menuItems.menuItems[index].name),
                leading: FadeInImage.assetNetwork(
                  fadeInCurve: Curves.easeIn,
                  placeholder: 'assets/placeholder.png',
                  image: menuItems.menuItems[index].image,
                  fit: BoxFit.cover,
                ),
                // subtitle: Text(menuItems.menuItems[index].items.toString()),
                subtitle: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuItems.menuItems[index].items.length,
                  itemBuilder: (context, i) {
                    return Text(menuItems.menuItems[index].items[i].toString());
                  },
                ),
                // trailing: Text(menuItems.menuItems[index].price),
                trailing: Text(fmf.output.symbolOnLeft),
              ),
            ),
          );
        },
        childCount: menuItems.menuItems.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var merchant = Provider.of<MerchantBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.docID),
          actions: <Widget>[
            IconButton(
              icon: Badge(
                badgeContent: Text(
                  merchant.cart.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.shopping_cart),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
                // x.signOut();
              },
            ),
          ],
        ),
        body: Center(
            child: FutureBuilder(
          future: _getMenu,
          // future: Provider.of<MerchantBloc>(context)
          //     .getMenuItems(widget.docID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                child: CustomScrollView(
                  slivers: <Widget>[
                    _menuList(merchant),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Text('$snapshot.error');
            }
            return CircularProgressIndicator();
          },
        )));
  }
}
