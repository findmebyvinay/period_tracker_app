import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracker_app/bloc/period_event.dart';
import 'package:period_tracker_app/view/dashboard_screen.dart';

import '../bloc/period_bloc.dart';
import '../model/user_data.dart';

class UserInputScreen extends StatefulWidget {
   UserInputScreen({super.key});


  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  
 final _formKey=GlobalKey<FormState>();
 DateTime? _lastPeriod;
 int _cycleLength=28;
 int _periodDuration=5;
 double weight=55.5;
 double height=5.1;
 List<String> _healthIssue=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Period Pal',
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
        color: Colors.pinkAccent),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(child: ListView(
          children: [
            _buildDatePicker(),
            _buildTextField('CycleLength(days)', (val)=>_cycleLength=int.parse(val)),
            _buildTextField('PeriodDuration(days)', (val)=>_periodDuration=int.parse(val)),
            _buildTextField('Height', (val)=> height=double.parse(val)),
            _buildTextField('Weight', (val)=> weight=double.parse(val)),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[300]
              ),
              onPressed:_submitData ,
               child: Text('Calculate',style: GoogleFonts.poppins(color: Colors.white),
               ))
          ],
        )),),
    );
  }

  
Widget _buildDatePicker(){
  return ListTile(
    title: Text(_lastPeriod==null?'Select last Period Date':'LastPeriod: ${_lastPeriod!.toString().substring(0,10)}'),
    trailing: const Icon(Icons.calendar_today,color: Colors.white,),
    onTap: () async{
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        );
        if(picked!=null){
          setState(() {
            _lastPeriod=picked;
          });
        }
    },
  );
}
Widget _buildTextField(String label,Function(String) onSaved){
  return Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
  child: TextFormField(
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    keyboardType: TextInputType.number,
    onChanged: (val)=>onSaved(val),
  ),);
}
Widget _buildHealthIssueChip(){
  return Wrap(
    spacing: 8.0,
    children: ['PCOS','Endometrisis','none'].map((issue){
      return ChoiceChip(
        label: Text(issue),
        selected: _healthIssue.contains(issue),
        onSelected: (selected){
          setState(() {
            if(selected)_healthIssue.add(issue);
            else _healthIssue.remove(issue);
          });
        }
      );
    }).toList(),
  );
}

void _submitData() {
    if (_formKey.currentState!.validate() && _lastPeriod != null) {
      final userData = UserData(
        lastPeriodStart: _lastPeriod!,
        cycleLength: _cycleLength,
        periodDuration: _periodDuration,
        weight: weight,
        height: height,
        healthIssue: _healthIssue,
      );
      context.read<PeriodBloc>().add(SubmitUserData(userData));
      Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
    }
  }
}
