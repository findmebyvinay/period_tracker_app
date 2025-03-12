import 'package:flutter/material.dart';

import '../theme/app_theme.dart';


class GradientCard extends StatelessWidget {
  final Widget child;
  final double elevation;

  const GradientCard({
    Key? key,
    required this.child,
    this.elevation = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.secondaryColor.withOpacity(0.1),
              AppTheme.accentColor.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}