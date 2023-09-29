import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: defaultColor,
    appBarTheme: const AppBarTheme(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color:
          Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,

    ),
    textTheme: const TextTheme(
        /*bodyText1: TextStyle(
          fontSize: 2,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),*/
    ),
    fontFamily: 'jannah',
);
ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
  ),

);