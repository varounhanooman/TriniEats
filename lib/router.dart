import 'package:flutter/material.dart';
import 'package:trini_eats/screens/cart.dart';
import 'package:trini_eats/screens/user.dart';
import 'package:trini_eats/services/auth.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Auth());
      // case '/route_overview':
      //   // pass parameters to route
      //   var data = settings.arguments as SingleRoute;
      //   return MaterialPageRoute(builder: (_) => RouteOverview(data));
      case '/cart':
        return MaterialPageRoute(builder: (_) => Cart());
      case '/user':
        return MaterialPageRoute(builder: (_) => User());
      // case '/route_to_work':
      //   return MaterialPageRoute(builder: (_) => RouteToWork());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
