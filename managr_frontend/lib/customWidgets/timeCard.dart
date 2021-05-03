import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {
  var time;
  var date;
  
  @override
  _TimeCardState createState() => _TimeCardState();

  TimeCard({this.time, this.date});
}

class _TimeCardState extends State<TimeCard> {

  ValueNotifier<bool> dateChosen1 = new ValueNotifier(false);
  ValueNotifier<bool> dateChosen2 = new ValueNotifier(false);
  ValueNotifier<bool> dateChosen3 = new ValueNotifier(false);
  ValueNotifier<bool> dateChosen4 = new ValueNotifier(false);
  ValueNotifier<bool> dateChosen5 = new ValueNotifier(false);
  ValueNotifier<bool> dateChosen6 = new ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth / 1.1,
      height: screenHeight / 1.2,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              dateChosen1.value = !dateChosen1.value;
            },
            child: ValueListenableBuilder(
              valueListenable: dateChosen1,
              builder: (context, value, child) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: value ? Colors.blue[200]: Colors.deepOrange[200],
                  child: Container(
                    width: screenWidth / 2.5,
                    height: screenHeight / 5,
                    child: Center(child: Text("May 2, 2021", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              dateChosen2.value = !dateChosen2.value;
            },
            child: ValueListenableBuilder(
              valueListenable: dateChosen2,
              builder: (context, value, child) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: value ? Colors.blue[200]: Colors.deepOrange[200],
                  child: Container(
                    width: screenWidth / 2.5,
                    height: screenHeight / 5,
                    child: Center(child: Text("May 4, 2021", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              dateChosen3.value = !dateChosen3.value;
            },
            child: ValueListenableBuilder(
              valueListenable: dateChosen3,
              builder: (context, value, child) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: value ? Colors.blue[200]: Colors.deepOrange[200],
                  child: Container(
                    width: screenWidth / 2.5,
                    height: screenHeight / 5,
                    child: Center(child: Text("May 6, 2021", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              dateChosen4.value = !dateChosen4.value;
            },
            child: ValueListenableBuilder(
              valueListenable: dateChosen4,
              builder: (context, value, child) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: value ? Colors.blue[200]: Colors.deepOrange[200],
                  child: Container(
                    width: screenWidth / 2.5,
                    height: screenHeight / 5,
                    child: Center(child: Text("May 8, 2021", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              dateChosen5.value = !dateChosen5.value;
            },
            child: ValueListenableBuilder(
              valueListenable: dateChosen5,
              builder: (context, value, child) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: value ? Colors.blue[200]: Colors.deepOrange[200],
                  child: Container(
                    width: screenWidth / 2.5,
                    height: screenHeight / 5,
                    child: Center(child: Text("May 10, 2021", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              dateChosen6.value = !dateChosen6.value;
            },
            child: ValueListenableBuilder(
              valueListenable: dateChosen6,
              builder: (context, value, child) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: value ? Colors.blue[200]: Colors.deepOrange[200],
                  child: Container(
                    width: screenWidth / 2.5,
                    height: screenHeight / 5,
                    child: Center(child: Text("May 12, 2021", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  ),
                );
              },
            ),
          ),
        ],
        
      ),
    );

    // return Container(
    //   margin: EdgeInsets.only(top: 15),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         padding: EdgeInsets.only(bottom: 15, left: 15),
    //         child: Text(
    //           widget.date.toString(),
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       Container(
    //         width: screenWidth / 1.1,
    //         height: screenHeight / 5,
    //         child: ListView(
    //           scrollDirection: Axis.horizontal,
    //           children: [
    //             GestureDetector(
    //               onTap: () {
                    
    //               },
                  // child: Card(
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  //   color: Colors.deepOrange[200],
                  //   child: Container(
                  //     width: screenWidth / 2.5,
                  //     height: screenHeight / 5,
                  //     child: Center(child: Text(widget.time.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  //   ),
                  // ),
    //             ),
    //             GestureDetector(
    //               onTap: () {
                    
    //               },
    //               child: Card(
    //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //                 color: Colors.deepOrange[200],
    //                 child: Container(
    //                   width: screenWidth / 2.5,
    //                   height: screenHeight / 5,
    //                   child: Center(child: Text(widget.time.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
    //                 ),
    //               ),
    //             ),
    //             GestureDetector(
    //               onTap: () {
                    
    //               },
    //               child: Card(
    //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //                 color: Colors.deepOrange[200],
    //                 child: Container(
    //                   width: screenWidth / 2.5,
    //                   height: screenHeight / 5,
    //                   child: Center(child: Text("8:00 AM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
    //                 ),
    //               ),
    //             ),
    //             GestureDetector(
    //               onTap: () {
                    
    //               },
    //               child: Card(
    //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //                 color: Colors.deepOrange[200],
    //                 child: Container(
    //                   width: screenWidth / 2.5,
    //                   height: screenHeight / 5,
    //                   child: Center(child: Text("8:00 AM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
