import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:http/http.dart' as http;

class Invitations extends StatefulWidget {
  @override
  _InvitationState createState() => _InvitationState();
}

class _InvitationState extends State<Invitations> {
  Future<http.Response> getEvent() async {
    var url = "http://managr-server.herokuapp.com/invitelist?person_id=2";
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
                    var event_id = eventData['event_id'];
                    var person_id = eventData['person_id'].toString();
                    var email = eventData['email'];
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
                                  "EventID:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  event_id,
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
                                  "PersonID:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  person_id,
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
                                  "Email:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  email,
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
