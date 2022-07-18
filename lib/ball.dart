import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballXaxis;
  final double ballYaxis;

  MyBall({required this.ballXaxis,required this.ballYaxis});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballXaxis,ballYaxis),
      child: Container(
        width: 40,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black,),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/images/flame.jpg"),
            fit: BoxFit.cover,
          )
          //color: Colors.purpleAccent,
        ),
      ),
    );
  }
}
