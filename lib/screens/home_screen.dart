import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/local_storage_service.dart';
import '../widgets/task_tile.dart';
import 'add_edit_task_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  String selectedPriority = 'Low';
  void addTask(String title, String? desc, String priorityStr) {
    final priorityEnum = Priority.values.byName(priorityStr.toLowerCase());

    tasks.add(
      Task(
        title: title,
        description: desc,
        priority: priorityEnum,
        dueDate: DateTime.now(),
      ),
    );

    LocalStorageService.saveTasks(tasks);
    setState(() {});
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    LocalStorageService.saveTasks(tasks);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    LocalStorageService.loadTasks().then((loadedTasks) {
      setState(() {
        tasks = loadedTasks;
      });
    });
  }

  void showAddDialog() {
    titleController.clear();
    descController.clear();
    selectedPriority = 'Low';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Task title'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: InputDecoration(hintText: 'Description (optional)'),
              ),
              SizedBox(height: 10),
              StatefulBuilder(
                builder: (context, setStateDialog) {
                  return DropdownButton<String>(
                    value: selectedPriority,
                    items: ['Low', 'Medium', 'High']
                        .map((p) => DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setStateDialog(() {
                        selectedPriority = val!;
                      });
                    },
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  addTask(
                      titleController.text, descController.text, selectedPriority);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart To-Do Manager')),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (val) {
                task.isCompleted = val!;
                setState(() {});
              },
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Text('${task.description ?? ''} [${task.priority}]'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
