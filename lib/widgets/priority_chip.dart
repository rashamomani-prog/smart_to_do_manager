import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PriorityChip extends StatelessWidget {
  final String priority;

  const PriorityChip({super.key, required this.priority});
  @override
  Widget build(BuildContext context) {
    const priorityColors = {
      'Low': AppColors.low,
      'Medium': AppColors.medium,
      'High': AppColors.high,
    };
    final color = priorityColors[priority] ?? Colors.grey;


    return Chip(
      label: Text(priority),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}
