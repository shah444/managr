import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bottomGrad,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Center(
            child: FutureBuilder(
                future: getEvent(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var eventData = jsonDecode(snapshot.data.body)[0];
                    var eventTitle = eventData['event_title'];
                    var date = eventData['date'];
                    var room_id = eventData['room_id'].toString();
                    var eventDetails = eventData['details'];
                    var invited_count = eventData['invited_count'].toString();
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  "Event:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  eventTitle,
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  "Details:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  eventDetails,
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  "Creation Date:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  date,
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  "Room ID:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  room_id,
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  "Invited Guests:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  invited_count,
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(onboardingStart),
                    );
                  }
                })),
      ),
    );
  }
}
