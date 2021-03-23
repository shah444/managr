import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  @override

  String text ;
  Icon icon;

  TextFieldContainer({this.text , this.icon});

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
      child: TextField(
        decoration: InputDecoration(
            icon: this.icon,
            hintText: this.text
        ),
      )
    );
  }
}