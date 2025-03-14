import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
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
                      const SizedBox(height: 24,),
                      _buildPredictionCards(state),
                      const SizedBox(height: 24,),
                      _buildQuickActions()
                ],
              ),),
          );
        }
        return const Center(
          child: Text('Please enter period data'),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed:(){
        _showAddPeriodDialog(context);
      } ,
      child:const Icon(Icons.add),),
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
  
Widget _buildPredictionCards(PeriodTrackerLoaded state) {
    return Column(
      children: [
        GradientCard(
          child: ListTile(
            leading: Text('next'),
            title: const Text('Next Period'),
            subtitle: Text(state.nextPeriodDate != null
                ? DateFormat.yMMMd().format(state.nextPeriodDate!)
                : 'Not enough data'),
          ),
        ),
        const SizedBox(height: 16),
        GradientCard(
          child: ListTile(
            leading: Text('ovulation'),
            title: const Text('Ovulation'),
            subtitle: Text(state.ovulationDate != null
                ? DateFormat.yMMMd().format(state.ovulationDate!)
                : 'Not enough data'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          icon: Icons.water_drop,
          label: 'Log Flow',
          onTap: () {},
        ),
        _buildActionButton(
          icon: Icons.mood,
          label: 'Add Mood',
          onTap: () {},
        ),
        _buildActionButton(
          icon: Icons.favorite,
          label: 'Symptoms',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  void _showAddPeriodDialog(BuildContext context) {
    final startDateController = TextEditingController(
      text: DateFormat.yMMMd().format(DateTime.now()),
    );
    int periodDuration = 5;
    int cycleDuration = 28;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Log New Period'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: startDateController,
              readOnly: true,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() {
                     startDateController.text = DateFormat.yMMMd().format(picked);
                  });
                 
                }
              },
              decoration: const InputDecoration(labelText: 'Start Date'),
            ),
            const SizedBox(height: 16),
            _buildNumberPicker(
              title: 'Period Duration',
              value: periodDuration,
              min: 2,
              max: 10,
              onChanged: (value) => setState(() {
                periodDuration = value;
              }),
            ),
            const SizedBox(height: 16),
            _buildNumberPicker(
              title: 'Cycle Duration',
              value: cycleDuration,
              min: 20,
              max: 40,
              onChanged: (value) => setState(() {
                cycleDuration = value;
              }),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final startDate = DateFormat.yMMMd().parse(startDateController.text);
              context.read<PeriodTrackerBloc>().add(
                AddPeriodData(
                  startDate: startDate,
                  periodDuration: periodDuration,
                  cycleDuration: cycleDuration,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
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
}