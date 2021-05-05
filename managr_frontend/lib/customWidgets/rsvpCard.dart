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
  Future<http.Response> getEvent() async {
    prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt(widget.rsvp);
    var url = "http://managr-server.herokuapp.com/invitation?attending=" +
        userID.toString();
    print("userID is " + userID.toString());
    http.Response resp = await http.get(url);
    print("response body is ${resp.body}");
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var _hasBeenPressed = false;
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
                            child: new Text('Attend Event'),
                            textColor: Colors.white,
                            // 2
                            color: widget.rsvp == 0 ? Colors.green : Colors.red,
                            // 3
                            onPressed: () => {
                              setState(() {
                                _hasBeenPressed = !_hasBeenPressed;
                              })
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
