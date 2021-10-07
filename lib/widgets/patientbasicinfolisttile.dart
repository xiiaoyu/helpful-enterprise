import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helpful_app/constant.dart';

class PatientBasicInfoListTile extends StatefulWidget {
  final String patientValue;
  final IconData newIcon;
  final String title;
  PatientBasicInfoListTile({this.patientValue, this.newIcon, this.title});

  @override
  _PatientBasicInfoListTileState createState() =>
      _PatientBasicInfoListTileState();
}

class _PatientBasicInfoListTileState extends State<PatientBasicInfoListTile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7.0,
      ),
      child: Container(
        child: Row(
          children: [
            Icon(
              widget.newIcon,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: width * 0.8),
                  child: Text(
                    '${widget.patientValue}',
                    style: TextStyle(
                      letterSpacing: 0.3,
                      fontSize: 20.0,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${widget.title}',
                  style: TextStyle(
                    letterSpacing: 0.3,
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
