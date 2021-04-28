import 'package:firebase_auth/firebase_auth.dart';

class DeleteUser {
  String email;
  String password;
  User user;

  DeleteUser(this.email, this.password, this.user);

  deleteUser() async {
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
}