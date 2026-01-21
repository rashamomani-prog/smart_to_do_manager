import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PriorityChip extends StatelessWidget {
  final String priority;

  const PriorityChip({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (priority) {
      case 'Low':
        color = AppColors.low;
        break;
      case 'Medium':
        color = AppColors.medium;
        break;
      case 'High':
        color = AppColors.high;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(priority),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}
