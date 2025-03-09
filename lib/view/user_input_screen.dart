import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
 
void _submitData() {
    if (_formKey.currentState?.validate()??false) {
      final userData = UserData(
        lastPeriodStart: _lastPeriod!,
        cycleLength: _cycleLength,
        periodDuration: _periodDuration,
        weight: weight,
        height: height,
        healthIssue: _healthIssue,
      );
      print('success');
      print(userData.lastPeriodStart);
      print(userData.cycleLength);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Submitted successfully') ));
      context.read<PeriodBloc>().add(SubmitUserData(userData));
      Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
    }
    else if (_formKey.currentState?.validate()==true){
      showDialog(
        context: context,
         builder: (BuildContext context){
          return AlertDialog(
            title: Text('Error Box',style: GoogleFonts.poppins(color: Colors.pink,fontWeight: FontWeight.bold),),
            content: Text('Please provide required data',style: GoogleFonts.poppins(color: Colors.pinkAccent,fontWeight: FontWeight.w400),),
          );
         });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text('Period Pal',
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
        color: Colors.pinkAccent),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: Lottie.asset('assets/images/rabbit.json'),
              ),
              const SizedBox(height: 24,),
             Center(
               child: Text('Please Provide the required data !',
               style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.pinkAccent),),
             ),
              const SizedBox(height: 24,),
              _buildDatePicker(),
              const SizedBox(height: 24,),
              _buildTextField('CycleLength(days)', (val)=>_cycleLength=int.parse(val)),
              const SizedBox(height: 24,),
              _buildTextField('PeriodDuration(days)', (val)=>_periodDuration=int.parse(val)),
              const SizedBox(height: 24,),
              _buildTextField('Height', (val)=> height=double.parse(val)),
              const SizedBox(height: 24,),
              _buildTextField('Weight', (val)=> weight=double.parse(val)),
              const SizedBox(height: 24,),
              _buildHealthIssueChip(),
              const SizedBox(height: 24,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[300]
                ),
                onPressed:_submitData,
                 child: Text('Calculate',style: GoogleFonts.poppins(color: Colors.white),
                 ))
            ],
          ),
        )),),
    );
  }

  
Widget _buildDatePicker(){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    
    child: ListTile(
      
      title: Text(_lastPeriod==null?'Select last Period Date':'LastPeriod: ${_lastPeriod!.toString().substring(0,10)}'),
      trailing: const Icon(Icons.calendar_today,color: Colors.pinkAccent,),
      onTap: () async{
        final picked = await showDatePicker(
          barrierColor: Colors.pink[100],
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
    ),
  );
}
Widget _buildTextField(String label,Function(String) onSaved){
  return Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
  child: TextFormField(
    decoration: InputDecoration(
    
      filled: true,
      fillColor: Colors.white,
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    keyboardType: TextInputType.number,
    validator:(value){
      if(value!.isEmpty){
        return 'Please enter the required data';
      }
      else{
        return null;
      }
    },
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

}
