import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future isUserLoggedIn() async {
    try {
      var user = _auth.currentUser;
      return user != null;
    } catch (e) {
      print(e.toString());
    }
  }
}
