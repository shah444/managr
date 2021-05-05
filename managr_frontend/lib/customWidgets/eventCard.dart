import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:managr_frontend/pages/editEvent.dart';
import 'package:managr_frontend/pages/invitedGuests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EventCard extends StatefulWidget {
  var event_id;
  var eventTitle;
  var eventDetails;
  var date;
  var invitedCount;
  var hostID;

  EventCard(this.event_id, this.eventTitle, this.eventDetails, this.date,
      this.invitedCount, this.hostID);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  SharedPreferences prefs;
  ValueNotifier<String> name = new ValueNotifier<String>("");
  var eventID;

  Future<void> getHostEvents() async {
    prefs = await SharedPreferences.getInstance();
    eventID = widget.event_id;
    var person_id = prefs.getString('name');
    var url = "http://managr-server.herokuapp.com/event/" + person_id + "?";
    print("event ID is " + eventID.toString());
    //var accDetails = JsonEncoder().convert({"event_id": eventID, "person_id": person_id});
    http.Response resp = await http.get(url);
    print("response body is ${resp.body}");
  }

  Future<void> cancelEvent() async {
    prefs = await SharedPreferences.getInstance();
    eventID = widget.event_id;
    var person_id = prefs.getString('name');
    var url = "http://managr-server.herokuapp.com/event/" + person_id + "?";
    print("event ID is " + eventID.toString());
    //var accDetails = JsonEncoder().convert({"event_id": eventID, "person_id": person_id});
    http.Response resp = await http.put(url);

    if (resp.statusCode == 200) {
      print("User information added into the database successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var givenDate = DateTime.parse(widget.date);
    final DateFormat dateFormat = DateFormat.yMMMMd('en_US');
    String date = dateFormat.format(givenDate);

    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.deepOrange[200],
        child: Container(
          width: screenWidth / 1.2,
          height: screenHeight / 3.5,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "Title: " + widget.eventTitle.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditEvent(
                                        widget.event_id,
                                        widget.eventTitle,
                                        widget.eventDetails,
                                        date,
                                        widget.invitedCount)));
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(
                          icon: Icon(Icons.people),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        InvitedGuests(widget.event_id)));
                          }),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Details: " + widget.eventDetails.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Date: " + date.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Invited Count: " + widget.invitedCount.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
