import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker_app/custom_widget/gradient_button.dart';
import 'package:period_tracker_app/theme/app_theme.dart';
import 'package:period_tracker_app/view/on_boarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(padding:const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/welcome.json',
            height: 300,
            repeat: true),
            const SizedBox(height: 40,),
            Text('Welcome to Luna',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign:TextAlign.center,),
            const SizedBox(height: 16,),
            Text('Your Personal Period Tracker and Health Companion',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTextColor
            ),),
            const SizedBox(height: 40,),
            GradientButton(
              text: 'Get Started',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen()));
              })
          ],
        ),) ),
    );

  }
}