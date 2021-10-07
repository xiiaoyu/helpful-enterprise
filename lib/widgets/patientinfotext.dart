import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';

class PatientInfoText extends StatelessWidget {
  final String infoTitle;
  final String patientInfoValue;

  PatientInfoText({this.infoTitle, this.patientInfoValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        '$infoTitle:${patientInfoValue == '' ? '空' : patientInfoValue}',
        style: TextStyle(fontSize: kPrimaryTextSize),
      ),
    );
  }
}
