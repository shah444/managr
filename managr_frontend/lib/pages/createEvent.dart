import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:managr_frontend/colors.dart';
import 'package:managr_frontend/customWidgets/locationCard.dart';
import 'package:http/http.dart' as http;
import 'package:managr_frontend/pages/eventCreationSuccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  PageController pageController = new PageController(initialPage: 0);
  ValueNotifier<int> dateIndex = new ValueNotifier(-1);
  ValueNotifier<String> chosenDate = new ValueNotifier("");
  ValueNotifier<int> roomIndex = new ValueNotifier(-1);
  ValueNotifier<String> chosenRoom = new ValueNotifier("");
  TextEditingController attendeeCountController = new TextEditingController();
  TextEditingController eventDescriptionController = new TextEditingController();
  TextEditingController eventTitleController = new TextEditingController();
  SharedPreferences prefs;
  String dateString;
  var chosenRoomCapacity = 0;
  var chosenRoomID = 0;


  Future<http.Response> getAvailableDays() async {
    var url = "http://managr-server.herokuapp.com/daysAvailability";
    http.Response resp = await http.get(url);
    print("resp.body is " + resp.body);
    return resp;
  }

  Future<http.Response> getAvailableRooms() async {
    if (chosenDate.value == "") {
      return null;
    } else {
      var url = "http://managr-server.herokuapp.com/roomsAvailability?date='${chosenDate.value}'";
      print(url);
      http.Response resp = await http.get(url);
      print("resp.body for available rooms is " + resp.body);
      return resp;
    }
  }

  createEvent() async {
    var url = "http://managr-server.herokuapp.com/event";
    var eventDetails = JsonEncoder().convert(
      {
        "host_id": prefs.getString('userID'),
        "evdate": dateString,
        "room_id": chosenRoomID,
        "event_title": eventTitleController.text,
        "details": eventDescriptionController.text,
      }
    );
    http.Response resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: eventDetails
    );

    if (resp.statusCode == 200) {
      print("Event information added into the database successfully");
    }
  }

  initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPreferences();
  }

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
                FutureBuilder(
                  future: getAvailableDays(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var availableDays = jsonDecode(snapshot.data.body)["days"];
                      print("available days are " + availableDays.toString());

                      return Container(
                        width: screenWidth / 1.1,
                        height: screenHeight / 1.2,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20
                          ),
                          itemCount: availableDays.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (dateIndex.value == index) {
                                  dateIndex.value = -1;
                                  chosenDate.value = "";
                                  dateString = "";
                                } else {
                                  dateIndex.value = index;
                                  chosenDate.value = availableDays[index].toString();
                                  dateString = availableDays[index].toString();
                                }
                              },
                              child: ValueListenableBuilder(
                                valueListenable: dateIndex,
                                builder: (context, value, child) {
                                  return Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    color: value == index ? Colors.blue[200]: Colors.deepOrange[200],
                                    child: Container(
                                      width: screenWidth / 2.5,
                                      height: screenHeight / 5,
                                      child: Center(child: Text(availableDays[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(onboardingStart),
                        ),
                      );
                    }
                  },
                ),
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
          body: ValueListenableBuilder(
            valueListenable: chosenDate,
            builder: (context, value, child) {
              if (value == "") {
                return Center(child: Text("Please choose a date"),);
              } else {
                return Container(
                  width: screenWidth,
                  height: screenHeight,
                  margin: EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      Text("Choose a location...", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      Container(
                        width: screenWidth / 1.1,
                        height: screenHeight / 1.6,
                        child: FutureBuilder(
                          future: getAvailableRooms(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var availableRooms = jsonDecode(snapshot.data.body);
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: availableRooms.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (roomIndex.value == index) {
                                        roomIndex.value = -1;
                                        chosenRoom.value = "";
                                        chosenRoomCapacity = 0;
                                      } else {
                                        roomIndex.value = index;
                                        chosenRoom.value = availableRooms[index]['room'].toString();
                                        chosenRoomCapacity = availableRooms[index]['capacity'];
                                        chosenRoomID = availableRooms[index]['room_id'];
                                      }
                                    },
                                    child: ValueListenableBuilder(
                                      valueListenable: roomIndex,
                                      builder: (context, value, child) {
                                        var roomImageString = availableRooms[index]['room_id'].toString() + ".jpeg";
                                        return Container(
                                          margin: EdgeInsets.only(top: 30),
                                          child: LocationCard(roomImageString, availableRooms[index]['room'].toString(), availableRooms[index]['capacity'], value == index ? Colors.blue[200] : Colors.deepOrange[200]),
                                        );
                                      }
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(onboardingStart),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 70),
                        child: Text("Swipe right >>>", style: TextStyle(fontSize: 18),)
                      ),
                    ],
                  ),
                );
              }
            },
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
          body: ValueListenableBuilder(
            valueListenable: chosenRoom,
            builder: (context, value, child) {
              if (value == "") {
                return Center(
                  child: Text("Please select a room to proceed."),
                );
              } else {
                var hostName = "Host: " + prefs.getString('name');
                var date = "Date: " + dateString;
                var location = "Location: " + value;
                var capacity = "Max Hall Capacity: " + chosenRoomCapacity.toString();

                return SingleChildScrollView(
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
                          child: Text(hostName, style: TextStyle(fontSize: 22),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(date, style: TextStyle(fontSize: 22),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(location, style: TextStyle(fontSize: 22),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(capacity, style: TextStyle(fontSize: 22),),
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
                                controller: attendeeCountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Count"
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("Event Title:", style: TextStyle(fontSize: 22),),
                            ),
                            Container(
                              width: screenWidth / 2,
                              height: screenHeight / 15,
                              margin: EdgeInsets.only(left: 15, top: 10),
                              child: TextField(
                                controller: eventTitleController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Event Title"
                                ),
                              ),
                            )
                          ]                          
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("Event Description:", style: TextStyle(fontSize: 22),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 20),
                          child: TextField(
                            maxLines: 8,
                            controller: eventDescriptionController,
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
                                onPressed: () async {
                                  var attendeeCount = attendeeCountController.text;
                                  var eventTitle = eventTitleController.text;
                                  var eventDescription = eventDescriptionController.text;

                                  if (attendeeCount == "") {
                                    Fluttertoast.showToast(
                                      msg: "Please enter the attendee count",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 18
                                    );
                                  } else if (int.parse(attendeeCount) > chosenRoomCapacity) {
                                    Fluttertoast.showToast(
                                      msg: "Attendee count more than room capacity",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 18
                                    );
                                  } else if (int.parse(attendeeCount) < 0) {
                                    Fluttertoast.showToast(
                                      msg: "Invalid attendee count",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 18
                                    );
                                  } else if (eventTitle == "") {
                                    Fluttertoast.showToast(
                                      msg: "Please enter the event title",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 18
                                    );
                                  } else if (eventDescription == "") {
                                    Fluttertoast.showToast(
                                      msg: "Please enter the event description",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 18
                                    );
                                  } else {
                                    // await createEvent();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EventCreationSuccess()));
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
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