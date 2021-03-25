import 'package:flutter/material.dart';
import 'package:myapp/pages/NormalContainer.dart';
import 'package:myapp/pages/TextFieldContainer.dart';
class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Create account" ,   style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldContainer(text: "First Name", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Last Name", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Your Email", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Your Password", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Re-Enter Password", icon: Icon(Icons.person)),
            SizedBox(height: 10.0),
            NormalContainer(text: "Create Account", route: '/home'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
