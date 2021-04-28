import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:managr_frontend/pages/createEvent.dart';
import 'package:managr_frontend/pages/events.dart';
import 'package:managr_frontend/pages/invitation.dart';
import 'package:managr_frontend/pages/login.dart';
import 'package:managr_frontend/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPrefs();
  }
  
  initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: bottomGrad,
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()));
            }
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: screenWidth / 3,
                height: screenHeight / 16,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                buttonColor: buttonColor,
                child: RaisedButton(
                  child: Text("Create Event"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateEvent()),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  minWidth: screenWidth / 3,
                  height: screenHeight / 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  buttonColor: buttonColor,
                  child: RaisedButton(
                    child: Text("Retrieve events from database"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Events()),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  minWidth: screenWidth / 3,
                  height: screenHeight / 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  buttonColor: buttonColor,
                  child: RaisedButton(
                    child: Text("Invite List"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Invitations()),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                    minWidth: screenWidth / 3,
                    height: screenHeight / 16,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    buttonColor: buttonColor,
                    child: RaisedButton(
                      child: Text("Logout"),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
