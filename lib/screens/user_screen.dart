import 'package:flutter/material.dart';
import 'package:helpful_app/services/auth.dart';

import '../constant.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'UserScreen',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                tileColor: Colors.blueGrey[100],
                leading: Icon(Icons.person_add),
                title: Text(
                  '登出',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  await _authMethods.signOut().then(
                      (value) => Navigator.pushReplacementNamed(context, '/'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
