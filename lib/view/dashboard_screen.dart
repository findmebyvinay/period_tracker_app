import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker_app/bloc/period_bloc.dart';

import '../bloc/period_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        centerTitle: true,
        title: Text('Upcoming Cycle',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.pinkAccent),),
      ),
      body: BlocBuilder<PeriodBloc,PeriodState>(builder: (context,state){
        if(state is PeriodLoading){
          return const Center(child: CircularProgressIndicator());
        }
        else if(state is PeriodLoaded){
          final prediction=state.cycle;
          final userData= state.data;
          return Padding(padding:const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard('Next Period', DateFormat.yMMMd().format(prediction.nextPeriodStart)),
              const SizedBox(height: 12,),
              _buildCard('Ovulation Day', DateFormat.yMMMd().format(prediction.ovulationDays)),
            const SizedBox(height: 12,),
            _buildCard('Fertile Window', '${DateFormat.yMMMd().format(prediction.fertileEnd)}'),
            const SizedBox(height: 12,),
            if(userData.healthIssue.isNotEmpty)Text('Consult doctor for ${state.data.healthIssue.join(", ")}')
            ],
          ),);
        }
        if(state is PeriodError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error ')));
        }
        return const SizedBox();
      },
      ),
    );
  }
}

Widget _buildCard(String title,String value){
  return Card(
    elevation: 4,
    margin: EdgeInsets.symmetric(vertical: 8.0),
    shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(padding:const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16),)
        ,const SizedBox(width: 5,),
        Text(value,style: GoogleFonts.poppins(fontSize: 16),)
      ],
    ),),
  );
}