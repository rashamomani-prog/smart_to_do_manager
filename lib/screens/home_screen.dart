import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/local_storage_service.dart';
import '../widgets/task_tile.dart';
import 'add_edit_task_screen.dart';
import '../utils/priority_levels.dart';
// import '../widgets/app_logo.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorageService db = LocalStorageService();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    tasks = await db.getTasks();
    final priorityMap = {'High': 3, 'Medium': 2, 'Low': 1};
    tasks.sort((a, b) => priorityMap[b.priority]!.compareTo(priorityMap[a.priority]!));

    setState(() {});
  }

  int get completedTasks => tasks.where((t) => t.isCompleted).length;
  int get pendingTasks => tasks.where((t) => !t.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      appBar: AppBar(
        title: const Text('Rasha Do'),
        backgroundColor: const Color(0xFFE91E63),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Rasha Do',
                applicationVersion: '1.0.0',
                children: const [
                  Text('The app was created by Rasha to make organizing daily tasks easier.'),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // const SizedBox(height: 20),
          // const AppLogo(),
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Completed: $completedTasks',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Pending: $pendingTasks',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
              child: Text('No tasks yet', style: TextStyle(fontSize: 16)),
            )
                : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskTile(
                  task: task,
                  onDelete: () async {
                    await db.deleteTask(task.id!);
                    loadTasks();
                  },
                  onChanged: (value) async {
                    task.isCompleted = value!;
                    await db.updateTask(task);
                    loadTasks();
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE91E63),
        onPressed: () async {
          final Task? newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTaskScreen()),
          );

          if (newTask != null) {
            await db.insertTask(newTask);
            loadTasks();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

    );
  }
}
