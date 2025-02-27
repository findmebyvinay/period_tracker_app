import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker_app/const/image_const.dart';
import 'package:period_tracker_app/view/dashboard_page.dart';

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
    Timer(Duration(seconds: 5),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DashboardPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
      child: Container(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Lottie.asset(ImageConst.splash,height: 90,
          width: 200),
        ),
      ),
    ),
    );
  }
}