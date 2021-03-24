import 'package:flutter/material.dart';
import 'package:myapp/pages/NormalContainer.dart';
import 'package:myapp/pages/TextFieldContainer.dart';
class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Delete account" ,   style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldContainer(text: "Your Email", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Your Password", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Re-Enter Password", icon: Icon(Icons.person)),
            SizedBox(height: 10.0),
            NormalContainer(text: "Delete", route: "/login",)
          ],
        ),
      ),
    );
  }
}
