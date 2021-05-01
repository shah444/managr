import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {
  var time;
  var date;
  
  @override
  _TimeCardState createState() => _TimeCardState();

  TimeCard(this.time, this.date);
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 15, left: 15),
            child: Text(
              widget.date.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: screenWidth / 1.1,
            height: screenHeight / 5,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.deepOrange[200],
                    child: Container(
                      width: screenWidth / 2.5,
                      height: screenHeight / 5,
                      child: Center(child: Text(widget.time.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.deepOrange[200],
                    child: Container(
                      width: screenWidth / 2.5,
                      height: screenHeight / 5,
                      child: Center(child: Text(widget.time.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.deepOrange[200],
                    child: Container(
                      width: screenWidth / 2.5,
                      height: screenHeight / 5,
                      child: Center(child: Text("8:00 AM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.deepOrange[200],
                    child: Container(
                      width: screenWidth / 2.5,
                      height: screenHeight / 5,
                      child: Center(child: Text("8:00 AM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
