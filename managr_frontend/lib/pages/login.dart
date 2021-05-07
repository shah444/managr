import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:managr_frontend/pages/createAccount.dart';
import 'package:managr_frontend/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  SharedPreferences prefs;
  var loginSuccess = 0;
  

  loginUsingFirebase() async {
    var email = emailController.text;
    var password = passwordController.text;

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      print("Login successful");
      loginSuccess = 1;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return;
    }).catchError((onError) {
      print("Login error: $onError");
      return;
    });
  }

  getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    var email = emailController.text;
    var url = "http://managr-server.herokuapp.com/account?email='" + email + "'";
    var userInfo;
    try {
      http.Response response = await http.get(url);
      print('res is ' + response.body);
      userInfo = jsonDecode(response.body);
      print('name is ' + userInfo[0]['name'].toString());
    }
    catch(error) {
      print('Error while retrieving user info: ' + error.toString());
    }

    prefs.setInt('userID', userInfo[0]['person_id']);
    prefs.setString('name', userInfo[0]['name']);
    prefs.setString('email', userInfo[0]['email']);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenWidth = size.width;
    var screenHeight = size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: bottomGrad,
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.transparent),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text("Managr", style: TextStyle(fontSize: 60))
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
                    controller: emailController,
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
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    buttonColor: buttonColor,
                    child: RaisedButton(
                      child: Text("Login"),
                      elevation: 1,
                      highlightColor: Colors.blue,
                      onPressed: () async {
                        await loginUsingFirebase();
                        if (loginSuccess == 1) {
                          getUserInfo();
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: FlatButton(
                    child: Text("Create Account", style: TextStyle(decoration: TextDecoration.underline),),
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
      ),
    );
  }
}