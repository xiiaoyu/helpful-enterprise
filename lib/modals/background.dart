import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  Background({@required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -80,
            child: Image.asset(
              'asset/images/bg_top.png',
              width: width * 0.5,
            ),
          ),
          Positioned(
            top: 200,
            right: -60,
            child: Image.asset(
              'asset/images/bg_middle.png',
              width: width * 0.3,
            ),
          ),
          Positioned(
            bottom: -100,
            left: -120,
            child: Image.asset(
              'asset/images/bg_bottom.png',
              width: width * 0.5,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
