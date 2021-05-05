import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:managr_frontend/pages/homepage.dart';
import 'package:managr_frontend/pages/inviteUsers.dart';

import 'package:http/http.dart' as http;

class EventCreationSuccess extends StatefulWidget {
  @override
  _EventCreationSuccessState createState() => _EventCreationSuccessState();
}

class _EventCreationSuccessState extends State<EventCreationSuccess> {
  /*
  TextEditingController emailController = new TextEditingController();

  Future<void> inviteUsers() async {
    var email = emailController.text;

    var url = "http://managr-server.herokuapp.com/invitelist";
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
  */

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: bottomGrad,
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.transparent),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Congratulations!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Your event has been successfully created.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text("Your event currently has 0 invitees."),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  buttonColor: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minWidth: screenWidth / 5,
                  child: RaisedButton(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: Text("Invite Guests"),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InviteUsers()));
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  buttonColor: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minWidth: screenWidth / 5,
                  child: RaisedButton(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: Text("Back to home page"),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
