import 'package:flutter/material.dart';

class OptionListTile extends StatelessWidget {
  final String optionTitle;
  final String navigateTo;

  OptionListTile({this.optionTitle, this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.blueGrey[100],
      leading: Icon(Icons.person_add),
      title: Text(
        optionTitle,
        style: TextStyle(
          fontSize: 16.0,
          letterSpacing: 1.0,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, navigateTo);
      },
    );
  }
}
