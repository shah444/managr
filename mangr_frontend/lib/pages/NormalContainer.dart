import 'package:flutter/material.dart';

class NormalContainer extends StatelessWidget {
  @override
  String text;
  String route;

  NormalContainer({this.text , this.route} );
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: TextButton(
          onPressed: (){Navigator.pushNamed(context, this.route);},
          child: Text( this.text , style: TextStyle( color : Colors.black , fontSize: 20),)
      ),
    );
  }
}


