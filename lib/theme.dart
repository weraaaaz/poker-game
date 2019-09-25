import 'package:flutter/material.dart';

class AppTheme {
  AppTheme(){
    cardSuitBlack = TextStyle(
      fontSize: 25,
      color: black,
    );

    cardSuitRed = TextStyle(
      fontSize: 25,
      color: primaryRed,
    );

    cardRank = TextStyle(
      fontSize: 25,
      color: black,
    ); 
  }

  final primaryGreen = Color(0xffa0cc78);
  final primaryRed = Color(0xffda4302);
  final black = Color(0xff000000);
  final white = Color(0xffffffff);

  TextStyle cardSuitBlack;
  TextStyle cardSuitRed;
  TextStyle cardRank;
}

AppTheme appTheme = AppTheme();
