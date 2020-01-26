import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trini_eats/bloc/auth_bloc.dart';
import 'package:trini_eats/bloc/merchant_bloc.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  // ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(
    lazy: true,
    create: (_) => AuthBloc.instance(),
  ),
  ChangeNotifierProvider(
    lazy: true,
    create: (_) => MerchantBloc.instance(),
  )
];
// List<SingleChildWidget> dependentServices = [
//   ProxyProvider<AuthBloc, RouteBloc>(
//     update: (context, auth, route) => RouteBloc(authBloc: auth),
//   ),
//   ProxyProvider<AuthBloc, PassBloc>(
//     update: (context, auth, pass) => PassBloc(authBloc: auth),
//   ),
// ];
