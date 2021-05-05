import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:http/http.dart' as http;
import 'package:managr_frontend/customWidgets/invitedCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitedGuests extends StatefulWidget {
  var eventID;

  InvitedGuests(this.eventID);
  @override
  _InvitedGuestsState createState() => _InvitedGuestsState();
}

class _InvitedGuestsState extends State<InvitedGuests> {
  PageController eventPageController = new PageController(initialPage: 0);
  SharedPreferences prefs;

  Future<http.Response> getEvent() async {
    var url = "http://managr-server.herokuapp.com/invitedTo?event_id=" +
        widget.eventID.toString();
    http.Response resp = await http.get(url);
    print("response body is ${resp.body}");
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                        "My Invited Guests",
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
                                      "You have not invited anybody for this event."),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InvitedCard(data[index]['email'],
                                        data[index]['attending']);
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
    );
  }
}
