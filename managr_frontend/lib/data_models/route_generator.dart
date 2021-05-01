import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../pages/createAccount.dart';
import '../pages/homepage.dart';
import '../pages/createEvent.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => Login()
        );

      case '/add':
        return MaterialPageRoute(
          builder: (_) => CreateAccount()
        );
      
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomePage()
        );
      
      case '/createEvent':
        return MaterialPageRoute(
          builder: (_) => CreateEvent()
        );
    }
  }
}