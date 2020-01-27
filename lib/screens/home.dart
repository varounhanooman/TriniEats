import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';
import 'package:trini_eats/models/merchant.dart';
import 'package:trini_eats/widgets/product.dart';
import 'package:badges/badges.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future _getMerchants;

  Widget _searchField() {
    return Container(
      child: TextFormField(
        onFieldSubmitted: (String value) {},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Restaurants & cuisines',
          fillColor: Colors.black,
        ),
        style: TextStyle(color: Colors.white),
        // controller: _emailTextController,
        onSaved: (String value) {
          // _formData['email'] = value;
        },
      ),
    );
  }

  SliverAppBar _topHeader(context, cartLength) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      actions: <Widget>[
        IconButton(
          icon: Badge(
            badgeContent: Text(
              cartLength.toString(),
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
      expandedHeight: 160.0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              SafeArea(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Trini Eats',
                    // x.user.email,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Deliver now'),
                        Text('Current Location')
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/user');
                    },
                    tooltip: 'My Profile',
                  ),
                ],
              ),
              _searchField(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // _getMerchants = Future.microtask(() =>
    // Provider.of<MerchantBloc>(context, listen: false).checkForNull();
  }

  Widget _merchantList(Merchants merchants) {
    return SliverList(
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Product(
            docId: merchants.merchants[index].id,
            title: merchants.merchants[index].name,
            image: FadeInImage.assetNetwork(
              fadeInCurve: Curves.easeIn,
              placeholder: 'assets/placeholder.png',
              image: merchants.merchants[index].image,
              fit: BoxFit.cover,
            ),
          );
          // return ListTile(
          //   title: Text(merchants.merchants[index].name),
          // );
        },
        childCount: merchants.merchants.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var merchant = Provider.of<MerchantBloc>(context);
    return Scaffold(
        body: Center(
            // child: FutureBuilder(
            //     future: _getMerchants,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            // return
            child: merchant.isLoading == true
                ? CircularProgressIndicator()
                : Container(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _topHeader(context, merchant.cart.length),
                        _merchantList(merchant.allMerchants),
                      ],
                    ),
                  ) //;
            //   }
            //   if (snapshot.hasError) {
            //     return Text('$snapshot.error');
            //   }
            //   return CircularProgressIndicator();
            // },
            )
        // ),
        );
  }
}
