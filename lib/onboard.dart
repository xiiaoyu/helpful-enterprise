import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'screens/allpatient_screen.dart';
import 'screens/add_screen.dart';
import 'screens/home_screen.dart';
import 'screens/user_screen.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

int _page = 0;
final List<Widget> _children = [
  HomeScreen(),
  AllPatientScreen(),
  AddScreen(),
  UserScreen(),
];

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: kPrimaryColor,
        height: 60.0,
        index: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(
            Icons.supervisor_account_rounded,
            size: 30,
          ),
          Icon(
            Icons.add,
            size: 30,
          ),
          Icon(
            Icons.account_circle,
            size: 30,
          ),
        ],
      ),
      body: _children[_page],
    );
  }
}
