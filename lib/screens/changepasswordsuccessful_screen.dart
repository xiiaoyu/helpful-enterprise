import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';
import 'package:helpful_app/widgets/flatbutton.dart';

class ChangePasswordSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('asset/images/successfulLogo.png'),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                '成功!',
                style: kTitleTextStyle,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '您已經成功更換新的密碼，請重新登入!',
                style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              AllFlatButton(
                text: '登入',
                onPressedFunction: () {
                  Navigator.pushNamedAndRemoveUntil(context, 'loginScreen', (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
