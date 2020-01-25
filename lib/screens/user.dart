import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trini_eats/bloc/auth_bloc.dart';

class User extends StatelessWidget {
  const User({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBloc>(context);
    FirebaseUser user = auth.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email),
      ),
      body: Column(
        children: <Widget>[
          Text(user.uid),
          RaisedButton(
            child: Text('Sign Out'),
            onPressed: () {
              auth.signOut(context);
            },
          )
        ],
      ),
    );
  }
}
