import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:http/http.dart' as http;
import 'package:managr_frontend/customWidgets/eventCard.dart';
import 'package:managr_frontend/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  PageController eventPageController = new PageController(initialPage: 0);
  SharedPreferences prefs;

  Future<http.Response> getEvent() async {
    prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('userID');
    var url = "http://managr-server.herokuapp.com/event?event_id=" +
        userID.toString();
    print("userID is " + userID.toString());
    http.Response resp = await http.get(url);
    print("response body is ${resp.body}");
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: bottomGrad,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Container(
              width: screenWidth / 1.1,
              height: screenHeight / 1.1,
              margin: EdgeInsets.only(top: 55, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 1.2,
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(
                          "My Created Events",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: screenWidth / 1.3,
                          height: screenHeight / 1.3,
                          child: FutureBuilder(
                            future: getEvent(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = jsonDecode(snapshot.data.body);
                                if (data.length == 0) {
                                  return Center(
                                    child: Text(
                                        "You do not have any scheduled events."),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return EventCard(
                                          data[index]['event_id'],
                                          data[index]['event_title'],
                                          data[index]['details'],
                                          data[index]['date'],
                                          data[index]['invited_count'],
                                          data['host_id']);
                                    },
                                  );
                                }
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(onboardingStart),
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
