import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final Xaxis;

  MyPlayer({this.Xaxis});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(Xaxis, 1),
      child: ClipRRect(

        child: Container(
          //color: Colors.blue,
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/player.jpg"),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: Colors.deepPurple,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
