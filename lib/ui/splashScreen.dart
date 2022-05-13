import 'dart:async';
import 'package:Notex/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    Timer(
        Duration(milliseconds: 2100),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>HomePage())));


    return Scaffold(

      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Lottie.asset('images/todo.json',height: 800,width: 300),
      ),
    );
  }
}
