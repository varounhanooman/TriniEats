import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trini_eats/bloc/auth_bloc.dart';


List<SingleChildWidget> providers = [
  ...independentServices,
  // ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(
    create: (_) => AuthBloc.instance(),
  ),
];
// List<SingleChildWidget> dependentServices = [
//   ProxyProvider<AuthBloc, RouteBloc>(
//     update: (context, auth, route) => RouteBloc(authBloc: auth),
//   ),
//   ProxyProvider<AuthBloc, PassBloc>(
//     update: (context, auth, pass) => PassBloc(authBloc: auth),
//   ),
// ];
