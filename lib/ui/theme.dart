import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color magentaClr=Color(0xff6B5B95);
const Color orange=Color(0xffe6890f);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {

   static final light=ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xffeceff4),
    backgroundColor: Color(0xffeceff4),

  );

   static final dark=ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xff121212),
    backgroundColor: Color(0xff121212),
  );



}