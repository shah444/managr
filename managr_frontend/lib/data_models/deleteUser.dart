import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DeleteUser {
  String email;
  String password;
  User user;

  SharedPreferences prefs;

  DeleteUser(this.email, this.password, this.user);

  deleteUser() async {
    await deleteUserData();
    try {
      AuthCredential authCredential = EmailAuthProvider.credential(email: email, password: password);

      UserCredential userCredential = await user.reauthenticateWithCredential(authCredential);

      await userCredential.user.delete();

      print("user deleted from authentication successfully!");

      return "success";
      
    } catch (e) {
      print("error while deleting user: " + e.toString());
      return "fail";
    }
  }

  deleteUserData() async {
    prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt('userID');

    var url = "http://managr-server.herokuapp.com/account/" + userID.toString();
    http.delete(url).then((value) {
      print("delete successful!");
    }).catchError((onError) {
      print("user deletion failed due to an error: " + onError.toString());
    });
  }
}