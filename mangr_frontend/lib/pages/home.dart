import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("HomePage" ,   style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[850],

      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
                onPressed: (){Navigator.pushNamed(context, '/delete');},
                icon: Icon(Icons.add),
                label: Text('Delete Account' , style: TextStyle( color : Colors.white, fontSize: 30),)
            ),
            TextButton.icon(
                onPressed: (){Navigator.pushNamed(context, '/createEvent');},
                icon: Icon(Icons.add),
                label: Text('Create Event' , style: TextStyle( color : Colors.white, fontSize: 30),)
            ),
          ],
        ),
      ),

    );
  }
}

class TextFieldContainer extends StatelessWidget {
  @override
  final Widget child;
  TextFieldContainer({this.child});
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: child,
    );
  }
}



