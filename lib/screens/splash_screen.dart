import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helpful_app/services/auth.dart';

String finalEmail;
final AuthMethods _authMethods = AuthMethods();

// Future checkCurrentLoginEmail() async {
//   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   var obtainedEmail = sharedPreferences.getString('loginEmail');
//
//   finalEmail = obtainedEmail;
//
//   print(finalEmail);
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // void toLoginScreen() {
  //   Navigator.pushReplacementNamed(context, 'loginScreen');
  // }
  //
  // void toOnBoard() {
  //   Navigator.pushReplacementNamed(context, 'onBoard');
  // }

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authMethods.isUserLoggedIn();

    if (hasLoggedInUser) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, 'onBoard');
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, 'loginScreen');
      });
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    // checkCurrentLoginEmail();
    handleStartUpLogic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/helpfullogo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
