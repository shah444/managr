import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:managr_frontend/pages/editEvent.dart';

class EventCard extends StatefulWidget {
  var event_id;
  var eventTitle;
  var eventDetails;
  var date;
  var invitedCount;

  EventCard(this.event_id, this.eventTitle, this.eventDetails, this.date, this.invitedCount);

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
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(icon: Icon(Icons.edit), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditEvent(widget.event_id, widget.eventTitle, widget.eventDetails, date, widget.invitedCount)));
                      }),
                    ),
                  ),
                ],
              ),
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
    );
  }
}
