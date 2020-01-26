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
        title: Text('Profile'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0,),
            Text(user.email),
            Text(user.uid),
            RaisedButton(
              child: Text('Sign Out'),
              onPressed: () {
                auth.signOut(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
