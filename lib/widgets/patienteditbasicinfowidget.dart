import 'package:flutter/material.dart';

class PatientEditBasicInfoWidget extends StatefulWidget {
  final String title;
  final TextFormField valueTextFormField;

  PatientEditBasicInfoWidget({
    this.title,
    this.valueTextFormField,
  });

  @override
  _PatientEditBasicInfoWidgetState createState() => _PatientEditBasicInfoWidgetState();
}

class _PatientEditBasicInfoWidgetState extends State<PatientEditBasicInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${widget.title}:',
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: 18.0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: widget.valueTextFormField,
          ),
        ),
      ],
    );
  }
}
