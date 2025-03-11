import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:period_tracker_app/bloc/authentication/register_bloc.dart';
import 'package:period_tracker_app/bloc/authentication/register_event.dart';
import 'package:period_tracker_app/main.dart';
import 'package:period_tracker_app/model/user_profile.dart';

import '../custom_widget/circular_stepper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController= PageController();
  final _currentPage =0;
  final _totalPage=4;
  //form value

  final _nameController = TextEditingController();
  final _selectedDob = DateTime.now().subtract(const Duration(days: 365*20));
  int _cycleLength=28;
  int _periodLength=5;
   double height=160;//cm
   double weight=55;//kg

@override
void dispose(
) {
  _pageController.dispose();
  _nameController.dispose();
  super.dispose();
}
void _nextPage(){
  if(_currentPage<_totalPage-1){
    _pageController.nextPage(
      duration:const Duration(milliseconds: 300),
      curve: Curves.easeInOut);
  }}
  void _previousPage(){
    if(_currentPage>0){
      _pageController.previousPage(
        duration:const Duration(milliseconds: 300),
         curve:Curves.easeInOut);

    }
  }
  void SubmitUserData(){
    final userAge= DateTime.now().millisecondsSinceEpoch.toInt();

    final userProfile= UserProfile(
      id: '1',
      name: _nameController.text,
      age: userAge,
      height:height,
      weight: weight);

      context.read<RegisterBloc>().add(RegisterUser(userProfile: userProfile));
     // Get.to(()=> );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentPage>0 ? IconButton(onPressed:_previousPage,
         icon:const Icon(Icons.arrow_back_ios_new)):null,
      ),
      body: SafeArea(
        child:Column(
          children: [
            Padding(padding:const EdgeInsets.symmetric(horizontal: 24),
            child:CircularStepper(
              currentStep: _currentPage,
              totalSteps: _totalPage,
            ),),
            
            
          ],
        ) ),
    );
  }
}