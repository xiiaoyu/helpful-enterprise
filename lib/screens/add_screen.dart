import 'package:flutter/material.dart';
import '../widgets/optionlisttile.dart';
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
          OptionListTile(
            optionTitle: '新增病人',
            navigateTo: 'addPatientScreen',
          ),
        ],
      ),
    );
  }
}
