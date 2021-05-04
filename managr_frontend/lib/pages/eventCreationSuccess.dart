import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';

class EventCreationSuccess extends StatefulWidget {
  @override
  _EventCreationSuccessState createState() => _EventCreationSuccessState();
}

class _EventCreationSuccessState extends State<EventCreationSuccess> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: bottomGrad,
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.transparent),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Congratulations!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text("Your event has been successfully created.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text("Your event currently has 0 invitees."),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  buttonColor: buttonColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  minWidth: screenWidth / 5,
                  child: RaisedButton(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: Text("Invite Guests"),
                    onPressed: () async {
                    },
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