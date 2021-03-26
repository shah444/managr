import 'package:flutter/material.dart';
import './data_models/route_generator.dart';

void main() {
  runApp(Managr());
}

class Managr extends StatefulWidget {
  @override
  _ManagrState createState() => _ManagrState();
}

class _ManagrState extends State<Managr> {
  var firstScreen = '/login';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Managr App',
      initialRoute: firstScreen,
      onGenerateRoute: Router.generateRoute,
      onGenerateInitialRoutes: (initialRoute) {
        return [
          Router.generateRoute(
            RouteSettings(name: firstScreen)
          )
        ];
      },
    );
  }
}