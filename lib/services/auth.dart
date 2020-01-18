import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trini_eats/screens/home.dart';
import 'package:trini_eats/screens/login.dart';
import 'package:trini_eats/bloc/auth_bloc.dart';


class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthBloc.instance(),
      child: Consumer(
        builder: (context, AuthBloc auth, _) {
          // return Login();
          switch (auth.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return Login();
            case Status.Authenticated:
              return Home();
          }
          return Splash();
        },
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
