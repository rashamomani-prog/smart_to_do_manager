import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/priority_levels.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task; 

  const AddEditTaskScreen({super.key, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String selectedPriority = PriorityLevel.low;
  DateTime? dueDate;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descController.text = widget.task!.description ?? '';
      selectedPriority = widget.task!.priority;
      dueDate = DateTime.parse(widget.task!.dueDate);
    } else {
      dueDate = DateTime.now();
    }
  }

  Future<void> _pickDueDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => dueDate = picked);
    }
  }

  void _saveTask() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty')),
      );
      return;
    }

    Navigator.pop(
      context,
      Task(
        id: widget.task?.id,
        title: titleController.text.trim(),
        description: descController.text.trim(),
        priority: selectedPriority,
        dueDate: dueDate!.toIso8601String(),
        isCompleted: widget.task?.isCompleted ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title *'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Priority: '),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedPriority,
                  onChanged: (value) => setState(() => selectedPriority = value!),
                  items: PriorityLevel.values.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Due Date: '),
                const SizedBox(width: 10),
                Text(dueDate != null ? "${dueDate!.toLocal()}".split(' ')[0] : ''),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickDueDate,
                  child: const Text('Pick Date'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
