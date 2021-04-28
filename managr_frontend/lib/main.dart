import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './data_models/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Managr());
}

class Managr extends StatefulWidget {
  @override
  _ManagrState createState() => _ManagrState();
}

class _ManagrState extends State<Managr> {
  var firstScreen = '/login';

  void checkLoggedIn() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      firstScreen = '/home';
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLoggedIn();
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