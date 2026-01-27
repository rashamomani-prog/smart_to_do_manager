import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String selectedPriority = 'Low';
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descController.text = widget.task!.description ?? '';
      selectedPriority = widget.task!.priority;
      selectedDate = DateTime.parse(widget.task!.dueDate);
    }
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE91E63),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Color(0xFFE91E63)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),

      appBar:
      AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title *'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Priority: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedPriority,
                  onChanged: (value) => setState(() => selectedPriority = value!),
                  items: ['Low', 'Medium', 'High'].map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Due Date: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: pickDate,
                  child: Text(
                    '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16,
                        color: Colors.black),

                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty) return;

                final newTask = Task(
                  title: titleController.text,
                  description: descController.text,
                  priority: selectedPriority,
                  dueDate: '${selectedDate.year}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}',
                  isCompleted: widget.task?.isCompleted ?? false,
                  id: widget.task?.id,
                );

                Navigator.pop(context, newTask);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
                minimumSize: const Size(double.infinity, 48),
                  foregroundColor: Colors.white,
              ),

              child: const Text('Save Task', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
