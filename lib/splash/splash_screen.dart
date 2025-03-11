import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker_app/const/image_const.dart';
import 'package:period_tracker_app/view/user_input_screen.dart';
import 'package:period_tracker_app/view/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  
  
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>WelcomeScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body:  Center(
      child: Container(
        color: Colors.pink[100],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: Lottie.asset(ImageConst.splash,height: 200,
          width: 200),
        ),
      ),
    ),
    );
  }
}