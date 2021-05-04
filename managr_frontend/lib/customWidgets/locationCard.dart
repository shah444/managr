import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:managr_frontend/colors.dart';

class LocationCard extends StatefulWidget {
  var imageString;
  var locationName;
  Color color;
  int capacity;

  LocationCard(this.imageString, this.locationName, this.capacity, this.color);

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var capacityString = "Capacity: " + widget.capacity.toString();

    return Container(
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: widget.color,
          child: Container(
            width: screenWidth / 1.8,
            height: screenHeight / 2,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                FutureBuilder(
                  future: FirebaseStorageService.getImage(context, widget.imageString.toString()),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data),
                        maxRadius: screenWidth / 5,
                      );
                    } else {
                      return CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: buttonColor,
                        valueColor: AlwaysStoppedAnimation(loginButtonStart),
                      );
                    }
                }),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(widget.locationName.toString(), style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),)
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(capacityString, style: TextStyle(fontSize: 20),)
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text("View more info", style: TextStyle(fontSize: 20, decoration: TextDecoration.underline),)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();
  static Future<dynamic> getImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance
        .ref()
        .child("eventLocations")
        .child(image)
        .getDownloadURL();
  }
}