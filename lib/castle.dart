import 'package:flutter/material.dart';

class MyCastle extends StatelessWidget {
  const MyCastle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 600,
        child: Container(
          alignment: Alignment(0,0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
            )
          ),
        ),
    );
  }
}
