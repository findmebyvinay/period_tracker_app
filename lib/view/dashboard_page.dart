import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
    centerTitle: true,
    backgroundColor: Colors.grey[100],
    title:Text('Period Tracker',
    style:GoogleFonts.poppins(fontWeight:FontWeight.bold )),
   ),
   body: Center(
     child: Column(
      children: [
        Text('heloo')
      ],
     ),
   ),
    );
  }
}