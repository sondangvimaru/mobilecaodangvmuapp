import 'package:caodangvmu/animation/wave_animation.dart';
import 'package:caodangvmu/background/wave_background.dart';
import 'package:caodangvmu/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:nice_button/NiceButton.dart';
class Editpage extends StatelessWidget {

  hexcolor(String color)
  {
    String colornew="0xff"+color;
    colornew=colornew.replaceAll("#", '');
    int colorint=int.parse(colornew);
    return colorint;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin",style: TextStyle(color: Colors.white,fontSize: 20),),

      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: wave_background()),
          onBottom(Wave_animation(
            height: 180,
            speed: 1.0,
          )),
          onBottom(Wave_animation(
            height: 120,
            speed: 0.9,
            offset: pi,
          )),
          onBottom(Wave_animation(
            height: 220,
            speed: 1.5,
            offset: pi / 2,
          )),
          Positioned.fill(child: Center(
            child: Container(
              height: 550,
              child: ListView(

                children: <Widget>[

                  Text("Edit")
                ],
              ),
            ),
          )),],
      ),
    );
  }

  onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}