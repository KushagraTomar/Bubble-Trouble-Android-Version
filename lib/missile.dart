import 'package:flutter/material.dart';

class MyMissile extends StatelessWidget {
  final missileX;
  final missileHeight;

  MyMissile({this.missileX,this.missileHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX,1),
      child: Container(
        width: 11,
        height: missileHeight,
        color: Colors.red,
      ),
    );
  }
}
