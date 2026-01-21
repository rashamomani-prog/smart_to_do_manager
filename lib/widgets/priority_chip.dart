import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class PriorityChip extends StatelessWidget {
  final Priority priority;

  const PriorityChip({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (priority) {
      case Priority.low:
        color = AppColors.low;
        break;
      case Priority.medium:
        color = AppColors.medium;
        break;
      case Priority.high:
        color = AppColors.high;
        break;
    }

    return Chip(
      label: Text(priority.name),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}
