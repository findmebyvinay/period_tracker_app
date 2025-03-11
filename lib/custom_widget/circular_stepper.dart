import 'package:flutter/material.dart';
class CircularStepper extends StatelessWidget {
  /// The current active step (0-indexed)
  final int currentStep;
  
  /// The total number of steps
  final int totalSteps;
  
  /// The size of each circle indicator
  final double dotSize;
  
  /// The color of the active step
  final Color activeColor;
  
  /// The color of inactive steps
  final Color inactiveColor;
  
  /// The thickness of the connecting line between steps
  final double lineThickness;
  
  /// The spacing between dots
  final double spacing;

  const CircularStepper({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.dotSize = 16.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.lineThickness = 2.0,
    this.spacing = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps * 2 - 1, (index) {
        // If it's an even index, it's a dot
        if (index % 2 == 0) {
          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= currentStep;
          
          return Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: dotSize * 0.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } 
        // If it's an odd index, it's a connecting line
        else {
          final prevStepIndex = index ~/ 2;
          final isActive = prevStepIndex < currentStep;
          
          return Container(
            width: spacing,
            height: lineThickness,
            color: isActive ? activeColor : inactiveColor,
          );
        }
      }),
    );
  }
}
