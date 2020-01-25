import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
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

  SliverAppBar _topHeader(context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
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

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Text('Item ${i.toString()}',
              style: new TextStyle(fontSize: 18.0))));
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _topHeader(context),
          SliverList(
            delegate: SliverChildListDelegate(_buildList(50)),
          ),
        ],
      ),
    );
  }
}
