import 'package:flutter/material.dart';
import 'package:helpful_app/modals/background.dart';
import 'package:helpful_app/widgets/flatbutton.dart';
import 'package:helpful_app/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMethods _authMethods = AuthMethods();

  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  bool showSpinner = false;

  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            height: height,
            child: Background(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage('asset/images/helpfullogo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '電子郵件',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailEditingController,
                            validator: (value) {
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)
                                  ? null
                                  : "Email格式不正確.";
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            '密碼',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _passwordEditingController,
                            validator: (value) {
                              return value.isEmpty || value.length < 6 ? '密碼最少為6個字.' : null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'forgotPasswordScreen');
                                },
                                child: Text('忘記密碼？'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    AllFlatButton(
                      text: '登入',
                      onPressedFunction: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          var result = await _authMethods.signInWithEmailAndPassword(
                              _emailEditingController.text, _passwordEditingController.text);
                          if (result == null) {
                            setState(() {
                              showSpinner = false;
                            });
                          } else {
                            Navigator.pushReplacementNamed(context, 'onBoard');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
