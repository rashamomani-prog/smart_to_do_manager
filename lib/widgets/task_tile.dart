import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'priority_chip.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: onChanged,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration:
          task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: PriorityChip(priority: task.priority),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
