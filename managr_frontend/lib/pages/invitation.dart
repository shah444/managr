import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:http/http.dart' as http;
import 'package:managr_frontend/customWidgets/rsvpCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Invitations extends StatefulWidget {
  @override
  _InvitationState createState() => _InvitationState();
}

class _InvitationState extends State<Invitations> {
  SharedPreferences prefs;
  Future<http.Response> getEvent() async {
    prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('userID');
    var url = "http://managr-server.herokuapp.com/invitation?person_id=" +
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
        child: FutureBuilder(
            future: getEvent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = jsonDecode(snapshot.data.body);
                if (data.length == 0) {
                  return Center(
                    child: Text("You have not been invited to any event."),
                  );
                }
                return Container(
                  margin: EdgeInsets.only(top: 55, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              "Invited To",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // for (var i in text) Text(i.toString()),
                            for (var i = 0; i < data.length; i++)
                              (RsvpCard(
                                  data[i]['event_title'],
                                  data[i]['details'],
                                  data[i]['date'],
                                  data[i]['attending'],
                                  data[i]['building'],
                                  data[i]['room'])),
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
            }),
      ),
    );
  }
}
