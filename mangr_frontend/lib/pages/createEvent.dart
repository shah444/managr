import 'package:flutter/material.dart';
import 'package:myapp/pages/NormalContainer.dart';
import 'package:myapp/pages/TextFieldContainer.dart';

class createEvent extends StatefulWidget {
  @override
  _createEventState createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Create Event" ,   style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldContainer(text: "Room Name", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Guest Count", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Date", icon: Icon(Icons.person)),
            TextFieldContainer(text: "Event Name", icon: Icon(Icons.person)),
            SizedBox(height: 10.0),
            NormalContainer(text: "Create Event", route: '/home'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
