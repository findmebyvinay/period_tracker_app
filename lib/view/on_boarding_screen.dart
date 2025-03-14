import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:period_tracker_app/bloc/authentication/register_bloc.dart';
import 'package:period_tracker_app/bloc/authentication/register_event.dart';
import 'package:period_tracker_app/custom_widget/gradient_button.dart';
import 'package:period_tracker_app/main.dart';
import 'package:period_tracker_app/model/user_profile.dart';
import 'package:period_tracker_app/theme/app_theme.dart';
import 'package:period_tracker_app/view/main_screen.dart';

import '../bloc/periodTracker/period_tracker_bloc.dart';
import '../bloc/periodTracker/period_tracker_event.dart';
import '../bloc/periodTracker/period_tracker_state.dart';
import '../custom_widget/circular_stepper.dart';
import '../custom_widget/gradient_card.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController= PageController();
  int _currentPage =0;
  final _totalPage=4;
  //form value

  final _nameController = TextEditingController();
  DateTime _selectedDob = DateTime.now().subtract(const Duration(days: 365*20));
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
  }
  else{
    submitUserData();
  }}
  void _previousPage(){
    if(_currentPage>0){
      _pageController.previousPage(
        duration:const Duration(milliseconds: 300),
         curve:Curves.easeInOut);

    }
  }
  void submitUserData(){
    final userAge= DateTime.now().millisecondsSinceEpoch.toInt();

    final userProfile= UserProfile(
      id: '1',
      name: _nameController.text,
      age: userAge,
      height:height,
      weight: weight);

      context.read<RegisterBloc>().add(RegisterUser(userProfile: userProfile));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
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
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child:Column(
          children: [
            Padding(padding:const EdgeInsets.symmetric(horizontal: 24),
            child:CircularStepper(
              currentStep: _currentPage,
              totalSteps: _totalPage,
            ),),
            Expanded(child: PageView(
              controller: _pageController,
              physics:const NeverScrollableScrollPhysics(),
              onPageChanged: (index){
                setState(() {
                  _currentPage=index;
                });
              },
              children: [
                    _buildBasicInfo(),
                    _buildPeriodInfo(),
                    _buildBodyMeasurementInfo(),
                    _buildHealthConcernPage()
              ],
            )),
            Padding(padding:const EdgeInsets.symmetric(horizontal: 24,vertical: 32),
            child: GradientButton(text: _currentPage==_totalPage-1?'Finish':'Next',
             onPressed: _nextPage),)
            
            
            
          ],
        ) ),
    );
  }

  
Widget _buildBasicInfo(){
  return Padding(padding: const EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Lets get to know you',
      style: Theme.of(context).textTheme.displayMedium,),
      const SizedBox(height: 8,),
      Text('Tell us abit about yourself',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppTheme.lightTextColor
      ),),
      const SizedBox(height: 32,),
      TextFormField(
        controller: _nameController,
        decoration:const InputDecoration(
          labelText: 'Full name',
          hintText: 'enter your name'
        
        ),
        validator: (value){
          if(value!.isEmpty){
            return 'Please enter your name';
          }
          else return null;
        },
      ),
      const SizedBox(height: 24,),

      GestureDetector(
        onTap: ()async{
          final picked = await showDatePicker(
            context: context,
            initialDate: _selectedDob,
            firstDate: DateTime(1900),
            lastDate: DateTime.now());
            if(picked !=null){
              setState(() {
                _selectedDob=picked;
              });
            }
        },
        child: Container(
          padding:const EdgeInsets.all(16),
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date of Birth: ${DateFormat.yMMMd().format(_selectedDob)}',
              style: Theme.of(context).textTheme.displayMedium,),

              const Icon(Icons.calendar_today,
              color: AppTheme.primaryColor,)
            ],
          ),
        ),
      )
    ],
  ),);
}
Widget _buildPeriodInfo(){
  return Padding(padding:const EdgeInsets.all(24),
  child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Cycle Information',
      style: Theme.of(context).textTheme.displayMedium,),
      const SizedBox(height: 5,),
      Text('Help us understand your cycle',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppTheme.lightTextColor
      ),),
      const SizedBox(height: 32,),

      _buildNumberPicker(
        title: 'Cycle Length(days)',
        value: _cycleLength,
        min: 20,
        max: 45,
        onChanged: (value)=> setState(() {
          _cycleLength=value;
        })),
        const SizedBox(height: 24,),
        _buildNumberPicker(
          title: 'Period Duration(days)',
          value:_periodLength,
          min: 2,
          max: 10,
          onChanged: (value)=>setState(() {
            _periodLength=value;
          }))
    ],
  ) ,);
}
Widget _buildBodyMeasurementInfo(){
  return Padding(padding:const EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Body Measurements',
      style: Theme.of(context).textTheme.displayMedium,),
      const SizedBox(height: 8,),
      Text('For Better Health Insights',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppTheme.lightTextColor
      ),),
      const SizedBox(height: 32,),
      _buildSlider(
        title: 'Height(cm)',
        value: height,
        min: 50,
        max: 250,
        onChanged: (value)=> setState(() {
          height=value;
        })),
        const SizedBox(height: 24,),

       _buildSlider(
        title: 'Weight',
         value: weight,
          min: 35,
           max: 300,
            onChanged: (value)=> setState(() {
              weight=value;
            }))
    ],
  ),);
}
Widget _buildSlider({
  required String title,
  required double value,
  required double min,
  required double max,
  required void Function(double) onChanged 
}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$title: ${value.toStringAsFixed(1)}',
      style: Theme.of(context).textTheme.bodyLarge,),

      Slider(
        value: value,
        min: min,
        max: max,
        activeColor: AppTheme.primaryColor,
        inactiveColor: AppTheme.accentColor.withOpacity(0.3),
        onChanged: onChanged)
    ],
  );
}
Widget _buildNumberPicker({
  required String title,
  required int value,
  required int min,
  required int max,
  required void Function(int) onChanged
}){
return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(title,style: Theme.of(context).textTheme.bodyLarge,),
    const SizedBox(height: 5,),
    Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
    IconButton(
      onPressed: ()=> value>min?onChanged(value-1):null,
       icon:const Icon(Icons.remove_circle_outline)),
       Text('$value',style: Theme.of(context).textTheme.displaySmall,),

       IconButton(onPressed: ()=>value<max?onChanged(value+1):null,
        icon:const Icon(Icons.add_circle_outline))
    ],)
  ],
);
}

Widget _buildHealthConcernPage(){
  return Padding(padding:const EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("You're all set!",
      style: Theme.of(context).textTheme.displayMedium,),
      const SizedBox(height: 8,),
      Text("We'll use this information to provide personalized insights",
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppTheme.lightTextColor
      ),),
      const SizedBox(height: 32,),
      Lottie.asset('assets/images/completed.json',
      height: 200)
    ],
  ),);
}

}


