import 'package:flutter/material.dart';
import 'package:helpful_app/modals/background.dart';
import 'package:helpful_app/widgets/flatbutton.dart';
import 'package:helpful_app/constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Background(
          child: Container(
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '忘記密碼',
                    style: kTitleTextStyle,
                  ),
                  Text(
                    '我們會發送重設密碼的邀請碼去您的電子郵件',
                    style: kDescriptionTextStyle,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    '電子郵件',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  AllFlatButton(
                    text: '發送',
                    onPressedFunction: () {
                      Navigator.pushReplacementNamed(context, 'resetPasswordScreen');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
