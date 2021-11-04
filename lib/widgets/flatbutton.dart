import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';

class AllFlatButton extends StatelessWidget {
  final String text;
  final Function onPressedFunction;

  AllFlatButton({@required this.text, @required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FlatButton(
      onPressed: onPressedFunction,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          text,
          style: TextStyle(
            letterSpacing: 3.0,
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ),
      color: kPrimaryColor,
      minWidth: width,
    );
  }
}
