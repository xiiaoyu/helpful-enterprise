import 'package:flutter/material.dart';
import 'package:helpful_app/modals/background.dart';
import 'package:helpful_app/widgets/flatbutton.dart';
import 'package:helpful_app/constant.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                    '重設密碼',
                    style: kTitleTextStyle,
                  ),
                  Text(
                    '已發送邀請碼去您的電子郵件，請輸入邀請碼和新的密碼',
                    style: kDescriptionTextStyle,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    '邀請碼',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    '新密碼',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    '確認密碼',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  AllFlatButton(
                    text: '更改密碼',
                    onPressedFunction: () {
                      Navigator.pushNamedAndRemoveUntil(context, 'changePasswordSuccessful', (route) => false);
                      // Navigator.pushNamed(context, 'changePasswordSuccessful');
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
