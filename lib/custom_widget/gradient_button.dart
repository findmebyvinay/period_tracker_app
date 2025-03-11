import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracker_app/theme/app_theme.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  const GradientButton({
    required this.text,
    required this.onPressed,
    this.width=double.infinity,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:const LinearGradient(colors: [
          AppTheme.primaryColor,AppTheme.secondaryColor
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      child:ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent
        ),
         child: Padding(
          padding:const EdgeInsets.symmetric(vertical: 15),
          child: Text(text,
          style:GoogleFonts.poppins(color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600),),)),
    );
  }
}