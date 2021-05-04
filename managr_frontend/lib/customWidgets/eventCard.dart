import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  var eventTitle;
  var eventDetails;
  var date;
  var invitedCount;

  EventCard(this.eventTitle, this.eventDetails, this.date, this.invitedCount);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    
    var givenDate = DateTime.parse(widget.date);
    final DateFormat dateFormat = DateFormat.yMMMMd('en_US') ;
    String date = dateFormat.format(givenDate);

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
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                      "Date: " + date.toString(),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Invited Count: " + widget.invitedCount.toString(),
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
