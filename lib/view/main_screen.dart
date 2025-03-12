import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:period_tracker_app/bloc/authentication/register_bloc.dart';
import 'package:period_tracker_app/bloc/periodTracker/period_tracker_event.dart';
import 'package:period_tracker_app/bloc/periodTracker/period_tracker_state.dart';
import 'package:period_tracker_app/custom_widget/gradient_card.dart';
import 'package:period_tracker_app/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/periodTracker/period_tracker_bloc.dart';

class MainScreen extends StatefulWidget {
 MainScreen({super.key});
 


  @override
  State<MainScreen> createState() => _MainScreenState();
  
}

class _MainScreenState extends State<MainScreen> {
   CalendarFormat _calendarFormat= CalendarFormat.month;
  DateTime _focusedDay=DateTime.now();
  DateTime? _selectedDay;
@override
void initState() {
  super.initState();
  context.read<PeriodTrackerBloc>().add(LoadPeriodData());
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luna',
        style: Theme.of(context).textTheme.titleMedium,),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<PeriodTrackerBloc,PeriodTrackerState>(builder: (context,state){
        if(state is PeriodTrackerLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(state is PeriodTrackerLoaded){
          return SingleChildScrollView(
              child: Padding(padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      _buildCalendar(state),
                ],
              ),),
          );
        }
        return const Center(
          child: Text('Please enter period data'),
        );
      }),
    );
  }

  Widget _buildCalendar(PeriodTrackerLoaded state){
    return GradientCard(
      child:TableCalendar(
        focusedDay:_focusedDay ,
        firstDay: DateTime.utc(2020,1,1),
         lastDay: DateTime.utc(2030,12,31),
         calendarFormat: _calendarFormat,
         selectedDayPredicate: (day)=>isSameDay(_selectedDay, day),
         onDaySelected: (selectedDay,focusedDay){
              setState(() {
                _selectedDay=selectedDay;
                _focusedDay=focusedDay;
              });
         },
         eventLoader: (day)=>state.calendarData[day]??[],
         onFormatChanged: (format) {
           setState(() {
             _calendarFormat=format;
           });
         },
         calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppTheme.secondaryColor.withOpacity(0.4),
            shape: BoxShape.circle
          ),
          selectedDecoration:const  BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle
          ),
          markerDecoration:const BoxDecoration(
            color: AppTheme.accentColor,
            shape: BoxShape.circle
          )

         ),
         ) );
  }
}