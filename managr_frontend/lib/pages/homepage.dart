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
  ValueNotifier<String> name = new ValueNotifier<String>("");

  void getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name');
    print("name is " + name.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPrefs();
    getUserInfo();
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              })
        ],
      ),
      body: Container(
        padding:
            EdgeInsets.only(top: screenHeight / 20, bottom: screenHeight / 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: ValueListenableBuilder(
                      valueListenable: name,
                      builder: (context, value, child) {
                        return Text(value, style: TextStyle(fontSize: 50));
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: screenWidth / 2,
                        height: screenHeight / 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        buttonColor: buttonColor,
                        child: RaisedButton(
                          child: Text("New Event"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateEvent()),
                            );
                          },
                        ),
                      ),
                      Container(
                        //padding: EdgeInsets.only(left: 20),
                        child: ButtonTheme(
                          minWidth: screenWidth / 2,
                          height: screenHeight / 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                            ),
                          ),
                          buttonColor: buttonColor,
                          child: RaisedButton(
                            child: Text("View Scheduled Events"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Events()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //padding: EdgeInsets.only(top: 20),
                        child: ButtonTheme(
                          minWidth: screenWidth / 2,
                          height: screenHeight / 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                            ),
                          ),
                          buttonColor: buttonColor,
                          child: RaisedButton(
                            child: Text("Invite List"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Invitations()),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        //padding: EdgeInsets.only(top: 20),
                        child: ButtonTheme(
                          minWidth: screenWidth / 2,
                          height: screenHeight / 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          buttonColor: buttonColor,
                          child: RaisedButton(
                            child: Text("Logout"),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
