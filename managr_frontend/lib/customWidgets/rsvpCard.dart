import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RsvpCard extends StatefulWidget {
  var eventTitle;
  var eventDetails;
  var date;
  var rsvp;
  var building;
  var room;

  RsvpCard(this.eventTitle, this.eventDetails, this.date, this.building,
      this.room, this.rsvp);

  @override
  _RsvpCardState createState() => _RsvpCardState();
}

class _RsvpCardState extends State<RsvpCard> {
  SharedPreferences prefs;
  Future<void> rsvpUpdate() async {
    prefs = await SharedPreferences.getInstance();
    int RSVP = widget.rsvp;
    var person_id = "9039";
    var event_id = "2";
    var url = "http://managr-server.herokuapp.com/rsvp";
    print("RSVP status is " + RSVP.toString());
    var accDetails =
        JsonEncoder().convert({"event_id": event_id, "person_id": person_id});
    http.Response resp = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: accDetails);

    if (resp.statusCode == 200) {
      print("User information added into the database successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var Attend = widget.rsvp == 0 ? "Attend Event" : "Cancel RSVP";

    return Container(
      child: GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.deepOrange[200],
          child: Container(
            width: screenWidth / 1.2,
            height: screenHeight / 2.7,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Title: " + widget.eventTitle.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Details: " + widget.eventDetails.toString(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Date: " + widget.date.toString(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Building: " + widget.building.toString(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Room: " + widget.room.toString(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "RSVP: " + widget.rsvp.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          RaisedButton(
                            child: new Text(Attend),
                            textColor: Colors.white,
                            // 2
                            color: widget.rsvp == 0 ? Colors.green : Colors.red,
                            // 3
                            onPressed: () async {
                              await rsvpUpdate();
                              Navigator.pop(context);
                            },
                          )
                        ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
