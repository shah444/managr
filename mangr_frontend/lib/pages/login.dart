import 'package:flutter/material.dart';
import 'package:myapp/pages/TextFieldContainer.dart';
import 'package:myapp/pages/NormalContainer.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Login Page" , style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[850],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldContainer(text: "Your Email", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Your Password", icon: Icon(Icons.person)),
            SizedBox(height: 40.0),
            NormalContainer(text: "Login", route: "/home",),
            SizedBox(height: 60.0),
            NormalContainer(text: "Create Account", route:"/add"),
          ],
        ),
      ),

    );
  }
}




