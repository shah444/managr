import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:managr_frontend/pages/createEvent.dart';
import 'package:managr_frontend/pages/events.dart';
import 'package:managr_frontend/pages/invitation.dart';
import 'package:managr_frontend/pages/login.dart';
import 'package:managr_frontend/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;
  ValueNotifier<String> name = new ValueNotifier<String>("Name");
  ValueNotifier<int> userID = new ValueNotifier<int>(null);

  void getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name');
    userID.value = prefs.getInt('userID');
    print("name is " + name.toString());
    print("id is " + userID.toString());
  }

  Future<http.Response> getUpcoming() async {
    prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('userID');
    var url = "http://managr-server.herokuapp.com/rsvp?person_id=" +
        userID.toString();
    print("userID is " + userID.toString());
    http.Response resp = await http.get(url);
    print("response body is ${resp.body}");
    return resp;
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
          actions: [
            IconButton(
                icon: Icon(Icons.account_circle),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Profile()));
                }),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
              top: screenHeight / 20, bottom: screenHeight / 20),
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
                          return Text(value.toString(),
                              style: TextStyle(fontSize: 50));
                        },
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                    future: getUpcoming(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = jsonDecode(snapshot.data.body);
                        if (data.length == 0) {
                          return Center(
                            child: Text("No Upcoming Events"),
                          );
                        }
                        var eventData = data[0];
                        var eventTitle = eventData['event_title'];
                        var eventDetails = eventData['details'];
                        //var invited_count = eventData['invited_count'].toString();
                        return Container(
                            child: Card(
                          margin: EdgeInsets.all(10),
                          clipBehavior: Clip.antiAlias,
                          color: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.arrow_drop_down_circle),
                                title: Text('Upcoming Event: ' + eventTitle),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  eventDetails, //style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              // Image.asset('assets/card-sample-image.jpg'),
                              //  Image.asset('assets/card-sample-image-2.jpg'),
                            ],
                          ),
                        ));
                      } else {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(onboardingStart),
                        );
                      }
                    }),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth / 2.2,
                            height: screenHeight / 4,
                            child: ButtonTheme(
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
                          ),
                          Container(
                            width: screenWidth / 2.2,
                            height: screenHeight / 4,
                            child: ButtonTheme(
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
                            width: screenWidth / 2.2,
                            height: screenHeight / 4,
                            child: ButtonTheme(
                              minWidth: screenWidth / 2.5,
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
                            width: screenWidth / 2.2,
                            height: screenHeight / 4,
                            child: ButtonTheme(
                              minWidth: screenWidth / 2.5,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
