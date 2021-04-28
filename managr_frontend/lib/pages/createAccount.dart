import 'dart:convert';

import 'package:flutter/material.dart';

import '../colors.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  Future<void> createAccount() async {
    var name = nameController.text;
    var email = emailController.text;
    var password = passwordController.text;
    var confirmPassword = confirmPasswordController.text;

    await addToFirebase(email, password, confirmPassword);

    var url = "http://managr-server.herokuapp.com/account";
    var accDetails = JsonEncoder()
        .convert({"name": nameController.text, "email": emailController.text});
    http.Response resp = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: accDetails);

    if (resp.statusCode == 200) {
      print("User information added into the database successfully");
    }
  }

  addToFirebase(String email, String password, String confirmPassword) {
    if (password == confirmPassword) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        print("Account successfully created!")
      }).catchError((onError) {
        print("Error creating account: $onError");
      });
    } else {
      print("Passwords do not match! Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bottomGrad,
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), hintText: "Name"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email), hintText: "Email"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock), hintText: "Password"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock), hintText: "Confirm Password"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: ButtonTheme(
                  minWidth: screenWidth / 3,
                  height: screenHeight / 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  buttonColor: buttonColor,
                  child: RaisedButton(
                    child: Text("Create Account"),
                    onPressed: () async {
                      await createAccount();
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
