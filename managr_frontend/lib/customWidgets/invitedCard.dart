import 'package:flutter/material.dart';

class InvitedCard extends StatefulWidget {
  var email;
  var attending;

  InvitedCard(this.email, this.attending);

  @override
  _InvitedCardState createState() => _InvitedCardState();
}

class _InvitedCardState extends State<InvitedCard> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var attending = widget.attending == 0 ? "is not attending" : "is attending";

    return Container(
      child: GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.deepOrange[200],
          child: Container(
            width: screenWidth / 1.2,
            height: screenHeight / 7,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      widget.email.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      attending,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
