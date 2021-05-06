import 'dart:convert';

import 'package:flutter/material.dart';

import '../colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InviteUsers extends StatefulWidget {
  @override
  _InviteUsersState createState() => _InviteUsersState();
}

class _InviteUsersState extends State<InviteUsers> {
  TextEditingController emailController = new TextEditingController();
  SharedPreferences prefs;
  var eventID;
  void getEventID() async {
    prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('userID');
    int roomID = prefs.getInt('roomID');

    var url = "http://managr-server.herokuapp.com/host/?host_id=" +
        userID.toString() +
        "&date=" +
        prefs.getString('date') +
        "&room=" +
        roomID.toString();
    print(url);
    http.Response resp = await http.get(url);
    print("response body is ${resp.body}");
    var data = jsonDecode(resp.body);

    eventID = data[0]['event_id'];
    print(eventID);
    //eventID = resp.body[0];
  }

  Future<void> inviteUsers() async {
    SharedPreferences prefs;

    var email = emailController.text;
    print(eventID);

    var url = "http://managr-server.herokuapp.com/invitation";
    var accDetails = JsonEncoder().convert(
        {"event_id": eventID.toString(), "email": emailController.text});
    http.Response resp = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: accDetails);
    if (resp.statusCode == 200) {
      print("User information added into the database successfully");
      Fluttertoast.showToast(
          msg: "Added User to the database",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPrefs();
    getEventID();
  }

  initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
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
