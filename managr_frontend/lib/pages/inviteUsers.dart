import 'dart:convert';

import 'package:flutter/material.dart';

import '../colors.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InviteUsers extends StatefulWidget {
  @override
  _InviteUsersState createState() => _InviteUsersState();
}

class _InviteUsersState extends State<InviteUsers> {
  TextEditingController emailController = new TextEditingController();

  Future<void> inviteUsers() async {
    var email = emailController.text;

    var url = "http://managr-server.herokuapp.com/invitation";
    var accDetails = JsonEncoder().convert({"email": emailController.text});
    http.Response resp = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: accDetails);

    if (resp.statusCode == 200) {
      print("User information added into the database successfully");
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
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email), hintText: "Guest Email"),
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
                    child: Text("Invite Guest to Event"),
                    onPressed: () async {
                      await inviteUsers();
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
