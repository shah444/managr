import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:managr_frontend/pages/createAccount.dart';
import 'package:managr_frontend/pages/homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return Scaffold(
      backgroundColor: bottomGrad,
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: "Email"
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: "Password"
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  minWidth: screenWidth / 3,
                  height: screenHeight / 16,
                  child: RaisedButton(
                    child: Text("Login"),
                    elevation: 1,
                    color: Colors.purple[100],
                    highlightColor: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: FlatButton(
                  child: Text("Create Account"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                    ); 
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}