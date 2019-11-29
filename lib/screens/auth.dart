import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/auth_bloc.dart';

import './login.dart';
import './home.dart';

class Auth extends StatelessWidget {
  const Auth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthBloc.instance(),
      child: Consumer(
        builder: (context, AuthBloc user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return Login();
            case Status.Authenticated:
              return Home();
          }
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