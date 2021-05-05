import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:managr_frontend/colors.dart';
import 'package:managr_frontend/data_models/deleteUser.dart';
import 'package:managr_frontend/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences prefs;
  ValueNotifier<String> name = new ValueNotifier<String>("");
  ValueNotifier<String> email = new ValueNotifier<String>("");

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController displayNameController = new TextEditingController();

  PageController profilePageController = new PageController(initialPage: 0);

  void getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name');
    email.value = prefs.getString('email');
    print("name is " + name.toString());
    print("email is " + email.toString());
  }

  updateName() {
    name.value = displayNameController.text;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return PageView(
      controller: profilePageController,
      scrollDirection: Axis.horizontal,
      children: [
        Scaffold(
          backgroundColor: bottomGrad,
          extendBodyBehindAppBar: true,
          appBar: new AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              IconButton(icon: Icon(Icons.edit), onPressed: () {
                profilePageController.jumpToPage(1);
              })
            ],
          ),
          body: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight / 3.5,
                color: buttonColor,
                child: Container(
                  margin: EdgeInsets.only(top: 70),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [Text("Member Since"), Text("2015")],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    maxRadius: 50,
                                    child: Container(
                                      decoration: ShapeDecoration(
                                          shape: CircleBorder(
                                              side: BorderSide(
                                                  width: 5,
                                                  color: Colors.orange[400]))),
                                      child: Container(
                                        // width: screenWidth / 4,
                                        // height: screenHeight / 4,
                                        decoration: ShapeDecoration(
                                            shape: CircleBorder(
                                                side: BorderSide(
                                                    width: 4,
                                                    color: Colors.orange[50]))),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://picsum.photos/250?image=18"),
                                          maxRadius: screenWidth / 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [Text("Events"), Text("100")],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 30),
                        child: ValueListenableBuilder(
                          valueListenable: name,
                          builder: (context, value, child) {
                            displayNameController.text = value;
                            return Text(
                              value.toString(),
                              style: TextStyle(fontSize: 25),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 225),
                      child: Text(
                        "User Profile Info",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text("Name:", style: TextStyle(fontSize: 18)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ValueListenableBuilder(
                              valueListenable: name,
                              builder: (context, value, child) {
                                return Text(value, style: TextStyle(fontSize: 18));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text("Email:", style: TextStyle(fontSize: 18)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ValueListenableBuilder(
                                valueListenable: email,
                                builder: (context, value, child) {
                                  return Text(
                                    value.toString(),
                                    style: TextStyle(fontSize: 25),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text("Events:", style: TextStyle(fontSize: 18)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("100", style: TextStyle(fontSize: 18)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 135),
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return WillPopScope(
                                child: Dialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  child: Container(
                                    width: screenWidth / 3,
                                    height: screenHeight / 3.5,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                              "Please enter your credentials to confirm."),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: TextField(
                                            controller: emailController,
                                            decoration:
                                                InputDecoration(hintText: "Email"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: TextField(
                                            controller: passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: "Password"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              color: Colors.red,
                                              child: Text("Delete account"),
                                              onPressed: () async {
                                                String enteredEmail =
                                                    emailController.text;
                                                String password =
                                                    passwordController.text;
                                                User user = FirebaseAuth
                                                    .instance.currentUser;

                                                DeleteUser deleteUser =
                                                    new DeleteUser(enteredEmail,
                                                        password, user);
                                                var deletionStatus =
                                                    await deleteUser.deleteUser();
                                                if (deletionStatus == "success") {
                                                  print(
                                                      "User deleted successfully");
                                                }

                                                emailController.clear();
                                                passwordController.clear();

                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Login()));
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onWillPop: () async {
                                  emailController.clear();
                                  passwordController.clear();
                                  return true;
                                });
                          });
                        },
                      );
                    },
                    elevation: 2,
                    child: Text("Delete account"),
                  ),
                ),
              )
            ],
          )),
        ),
        Scaffold(
          backgroundColor: bottomGrad,
          extendBodyBehindAppBar: true,
          appBar: new AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight / 3.5,
                  color: buttonColor,
                  child: Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [Text("Member Since"), Text("2015")],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                      maxRadius: 50,
                                      child: Container(
                                        decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(width: 5,color: Colors.orange[400]))),
                                        child: Container(
                                          decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(width: 4, color: Colors.orange[50]))),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage("https://picsum.photos/250?image=18"),
                                            maxRadius: screenWidth / 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [Text("Events"), Text("100")],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth / 2,
                          height: screenHeight / 20,
                          padding: const EdgeInsets.only(top: 10, left: 30),
                          child: TextField(
                            controller: displayNameController,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: "Display Name",
                              contentPadding: EdgeInsets.only(top: screenHeight / 55, left: screenWidth / 40),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 225),
                        child: Text(
                          "User Profile Info",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text("Name:", style: TextStyle(fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ValueListenableBuilder(
                                valueListenable: name,
                                builder: (context, value, child) {
                                  return Text(value, style: TextStyle(fontSize: 18));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text("Email:", style: TextStyle(fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ValueListenableBuilder(
                                  valueListenable: email,
                                  builder: (context, value, child) {
                                    return Text(
                                      value.toString(),
                                      style: TextStyle(fontSize: 25),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text("Events:", style: TextStyle(fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("100", style: TextStyle(fontSize: 18)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 135),
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: RaisedButton(
                      color: buttonColor,
                      onPressed: () async {
                        if (displayNameController.text == "") {
                          // Fluttertoast.showToast(
                          //   msg: "Please enter your display name",
                          //   toastLength: Toast.LENGTH_SHORT,
                          //   gravity: ToastGravity.BOTTOM,
                          //   backgroundColor: Colors.grey,
                          //   textColor: Colors.white,
                          //   fontSize: 18
                          // );
                        } else {
                          profilePageController.jumpToPage(0);
                          name.value = displayNameController.text;
                        }
                      },
                      elevation: 2,
                      child: Text("Save"),
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ],
    );
  }
}
