import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final Function(bool?) onChanged;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onChanged,
  });

  Color getPriorityColor() {
    const priorityColors = {
      'Low': AppColors.low,
      'Medium': AppColors.medium,
      'High': AppColors.high,
    };

    return priorityColors[task.priority] ?? Colors.grey;
  }


  @override
  Widget build(BuildContext context) {
    final color = getPriorityColor();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Checkbox(value: task.isCompleted, onChanged: onChanged),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.pinkAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
