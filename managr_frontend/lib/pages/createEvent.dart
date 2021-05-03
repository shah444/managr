import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';
import 'package:managr_frontend/customWidgets/locationCard.dart';
import 'package:managr_frontend/customWidgets/timeCard.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  PageController pageController = new PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return PageView(
      controller: pageController,
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: bottomGrad,
          appBar: new AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Text("Choose a date...", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                TimeCard(),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text("Swipe right >>>", style: TextStyle(fontSize: 18),)
                ),
              ],
            ),
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: bottomGrad,
          appBar: new AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            leading: new Container(),
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            margin: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Text("Choose a location...", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                Container(
                  width: screenWidth / 1.1,
                  height: screenHeight / 1.6,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: LocationCard("elliotHallOfMusic.jpeg", "Elliot Hall of Music", 6005)
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: LocationCard("loebPlayhouse.jpeg", "Loeb Playhouse", 1038,)
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: LocationCard("hilerTheatre.jpeg", "Hiler Theatre", 308,)
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: LocationCard("fowlerHall.jpeg", "Fowler Hall", 400)
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70),
                  child: Text("Swipe right >>>", style: TextStyle(fontSize: 18),)
                ),
              ],
            ),
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: bottomGrad,
          appBar: new AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            leading: new Container(),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height: screenHeight,
              margin: EdgeInsets.only(left: 50, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Event Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text("Host: Vidit S Shah", style: TextStyle(fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Date: April 29, 2021", style: TextStyle(fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Time: 8:00 AM", style: TextStyle(fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Location: Elliot Hall", style: TextStyle(fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Max Hall Capacity: 6005", style: TextStyle(fontSize: 22),),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text("Expected", style: TextStyle(fontSize: 22),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("Attendee Count", style: TextStyle(fontSize: 22),),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Text(":", style: TextStyle(fontSize: 22),),
                      ),
                      Container(
                        width: screenWidth / 6,
                        height: screenHeight / 15,
                        margin: EdgeInsets.only(left: 15),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Count"
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Event Description:", style: TextStyle(fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: TextField(
                      // keyboardType: TextInputType.multiline,
                      // textInputAction: TextInputAction.newline,
                      // minLines: 1,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintText: "Event Description"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: ButtonTheme(
                        buttonColor: buttonColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        minWidth: screenWidth / 5,
                        child: RaisedButton(
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          child: Text("Create Event"),
                          onPressed: () {
                            
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),   
        ),
      ],
    );

    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   backgroundColor: bottomGrad,
    //   appBar: new AppBar(
    //     elevation: 0,
    //     backgroundColor: Colors.transparent,
    //   ),
    //   body: Container(
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             margin: EdgeInsets.symmetric(vertical: 10),
    //             padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
    //             width: screenWidth * 0.8,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(9),
    //             ),
    //             child: TextField(
    //               decoration: InputDecoration(
    //                   icon: Icon(Icons.room),
    //                   hintText: "Room Name"
    //               ),
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.symmetric(vertical: 10),
    //             padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
    //             width: screenWidth * 0.8,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(9),
    //             ),
    //             child: TextField(
    //               decoration: InputDecoration(
    //                   icon: Icon(Icons.people),
    //                   hintText: "Guest Count"
    //               ),
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.symmetric(vertical: 10),
    //             padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
    //             width: screenWidth * 0.8,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(9),
    //             ),
    //             child: TextField(
    //               decoration: InputDecoration(
    //                   icon: Icon(Icons.timer),
    //                   hintText: "Date"
    //               ),
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.symmetric(vertical: 10),
    //             padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
    //             width: screenWidth * 0.8,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(9),
    //             ),
    //             child: TextField(
    //               decoration: InputDecoration(
    //                   icon: Icon(Icons.details),
    //                   hintText: "Event Name"
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(top: 20),
    //             child: ButtonTheme(
    //               minWidth: screenWidth / 3,
    //               height: screenHeight / 16,
    //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //               buttonColor: buttonColor,
    //               child: RaisedButton(
    //                 child: Text("Create Event"),
    //                 onPressed: () {
                      
    //                 },
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}