import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';

class PatientFeature extends StatelessWidget {
  final String title;
  final IconData icon;

  PatientFeature({@required this.title, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: kPrimaryColor,
        border: Border.all(
          width: 1.0,
          color: Colors.black,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
