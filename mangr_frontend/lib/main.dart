import 'package:flutter/material.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/loading.dart';
import 'package:myapp/pages/add.dart';
import 'package:myapp/pages/delete.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/pages/TextFieldContainer.dart';
void main() {
  runApp(MaterialApp(
    // home: Home(),
    initialRoute: '/login',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/add': (context) => Add(),
      '/delete' :(context) => Delete(),
      '/login' :(context) => Login()

    },
  ));
}

