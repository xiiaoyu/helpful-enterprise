import 'package:flutter/material.dart';

class PatientBasicTopInfo extends StatefulWidget {
  final String title;
  final String info;

  PatientBasicTopInfo({
    this.title,
    this.info,
  });

  @override
  _PatientBasicTopInfoState createState() => _PatientBasicTopInfoState();
}

class _PatientBasicTopInfoState extends State<PatientBasicTopInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.info,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
