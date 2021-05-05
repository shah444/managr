import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:http/http.dart' as http;
import 'package:managr_frontend/pages/events.dart';

class EditEvent extends StatefulWidget {
  var eventID;
  var eventTitle;
  var eventDetails;
  var date;
  var invitedCount;

  EditEvent(this.eventID, this.eventTitle, this.eventDetails, this.date,
      this.invitedCount);

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  TextEditingController eventTitleController = new TextEditingController();
  TextEditingController eventDetailsController = new TextEditingController();

  updateEventInformation() async {
    var url = "http://managr-server.herokuapp.com/event";

    var updatedInfo = JsonEncoder().convert({
      "event_id": widget.eventID.toString(),
      "event_title": eventTitleController.text,
      "event_details": eventDetailsController.text
    });

    http.Response resp = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: updatedInfo);

    if (resp.statusCode == 200) {
      print("Successfully updated event information.");
    } else {
      print("Error in updating user information.");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventTitleController.text = widget.eventTitle.toString();
    eventDetailsController.text = widget.eventDetails.toString();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var date = "Date: " + widget.date.toString();
    var invitedCount = "Invited Count: " + widget.invitedCount.toString();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bottomGrad,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          margin: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Text(
                  "Event Information",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Event Title: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: screenWidth / 2,
                      height: screenHeight / 20,
                      padding: EdgeInsets.only(left: 20),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: eventTitleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            contentPadding: EdgeInsets.only(
                                top: screenHeight / 40, left: screenWidth / 40),
                            hintText: "Event Title"),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 10),
                      child: Text(
                        "Event Details: ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: screenWidth / 1.1,
                      padding: EdgeInsets.only(left: 20),
                      child: TextField(
                        maxLines: 8,
                        textAlign: TextAlign.start,
                        controller: eventDetailsController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintText: "Event Details"),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50),
                child: Text(date, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50),
                child: Text(invitedCount, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: ButtonTheme(
                    buttonColor: buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minWidth: screenWidth / 5,
                    child: RaisedButton(
                        child: Text("Save"),
                        onPressed: () async {
                          await updateEventInformation();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Events()));
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
