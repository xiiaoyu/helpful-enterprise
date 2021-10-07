import 'package:flutter/material.dart';

import '../constant.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          '新增',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        children: [
          ListTile(
            tileColor: Colors.blueGrey[200],
            leading: Icon(Icons.person_add),
            title: Text(
              '新增病人',
              style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 1.0,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, 'addPatientScreen');
            },
          )
        ],
      ),
    );
  }
}
