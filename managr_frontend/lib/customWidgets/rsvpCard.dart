import 'package:flutter/material.dart';

class RsvpCard extends StatefulWidget {
  var eventTitle;
  var eventDetails;
  var date;
  var rsvp;

  RsvpCard(this.eventTitle, this.eventDetails, this.date, this.rsvp);

  @override
  _RsvpCardState createState() => _RsvpCardState();
}

class _RsvpCardState extends State<RsvpCard> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.deepOrange[200],
          child: Container(
            width: screenWidth / 1.2,
            height: screenHeight / 4.3,
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
                      "Invited Count: " + widget.rsvp.toString(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
