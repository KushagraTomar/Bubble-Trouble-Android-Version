import 'dart:async';
import 'package:bubble_trouble_android/button.dart';
import 'package:bubble_trouble_android/castle.dart';
import 'package:bubble_trouble_android/missile.dart';
import 'package:bubble_trouble_android/player.dart';
import 'package:bubble_trouble_android/ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double Xaxis = 0;
  // missile object features
  double missileX = Xaxis;
  double missileHeight = 10;
  bool midShot = false;
  // ball object features
  double ballXaxis = 0.5;
  double ballYaxis = 0.3;
  // ball initial direction set tp LEFT
  var ballDirection = direction.RIGHT;

  void startGame() {
    double t = 0;
    double h = 0;
    double v = 70;

    Timer.periodic(Duration(milliseconds: 20), (timer) {
      // quadratic equation to model bounce
      h = -5 * t * t + v * t;
      // if the ball reaches the ground reset the jump
      if (h < 0) {
        t = 0;
      }
      setState(() {
        ballYaxis = heightToCoordinate(h);
      });
      // if the ball hits left wall, change direction to right
      if (ballXaxis - 0.03 < -1) {
        ballDirection = direction.RIGHT;
      }
      // if the ball hits right wall, change direction to left
      else if (ballXaxis + 0.03 > 1) {
        ballDirection = direction.LEFT;
      }
      // move the ball in the correct direction
      if (ballDirection == direction.LEFT) {
        setState(() {
          ballXaxis -= 0.05;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballXaxis += 0.05;
        });
      }
      // check if ball hits the player
      if (playerDies()) {
        timer.cancel();
        _showDialog();
        ;
      }
      // keep the time going
      t += 0.1;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            alignment: Alignment(0,0),
            title: Center(
              child: Text(
                "You dead Bro.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  void moveLeft() {
    setState(() {
      if (Xaxis - 0.1 < -1) {
        //do-nothing
      } else {
        Xaxis -= 0.1;
      }
      if (!midShot) {
        missileX = Xaxis;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (Xaxis + 0.1 > 1) {
        //do-nothing
      } else {
        Xaxis += 0.1;
      }
      if (!midShot) {
        missileX = Xaxis;
      }
    });
  }

  void fireMissile() {
    if (midShot == false) {
      Timer.periodic(Duration(milliseconds: 20), (timer) {
        midShot = true; //shots fired

        // missile will grows till it
        // hits the top of the screen
        setState(() {
          missileHeight += 10;
        });

        // stop missile
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }
        // check if missile has hit the ball
        if (ballYaxis > heightToCoordinate(missileHeight) &&
            (ballXaxis - missileX).abs() < 0.005) {
          resetMissile();
          ballXaxis = 5;
          timer.cancel();
        }
      });
    }
  }

  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  void resetMissile() {
    midShot = false;
    missileX = Xaxis;
    missileHeight = 10;
  }

  bool playerDies() {
    // if the ball position and the player
    // position are same, then player dies
    if ((ballXaxis - Xaxis).abs() < 0.05 && ballYaxis > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fireMissile();
        }
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          startGame();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[100],
              child: Center(
                child: Stack(
                  children: [
                    MyCastle(),
                    MyBall(
                      ballXaxis: ballXaxis,
                      ballYaxis: ballYaxis,
                    ),
                    MyMissile(
                      missileX: missileX,
                      missileHeight: missileHeight,
                    ),
                    MyPlayer(
                      Xaxis: Xaxis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    icon: Icons.play_arrow,
                    function: startGame,
                  ),
                  MyButton(
                    icon: Icons.arrow_back_ios_new,
                    function: moveLeft,
                  ),
                  MyButton(
                    icon: Icons.arrow_upward,
                    function: fireMissile,
                  ),
                  MyButton(
                    icon: Icons.arrow_forward_ios,
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
