import 'package:flutter/material.dart';

class PatientAddCondition extends StatefulWidget {
  @override
  _PatientAddConditionState createState() => _PatientAddConditionState();
}

class _PatientAddConditionState extends State<PatientAddCondition> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '新增看診咨詢',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Stepper(
            currentStep: _currentStep,
            steps: <Step>[],
          ),
        ],
      ),
    );
  }
}
