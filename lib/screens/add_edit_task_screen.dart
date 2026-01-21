import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key});

  @override
  State<AddEditTaskScreen> createState() =>
      _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  Priority priority = Priority.low;
  DateTime dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
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
              decoration:
              const InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<Priority>(
              value: priority,
              onChanged: (value) {
                setState(() => priority = value!);
              },
              items: Priority.values.map((p) {
                return DropdownMenuItem(
                  value: p,
                  child: Text(p.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty) return;

                Navigator.pop(
                  context,
                  Task(
                    title: titleController.text,
                    description: descController.text,
                    priority: priority,
                    dueDate: dueDate,
                  ),
                );
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
