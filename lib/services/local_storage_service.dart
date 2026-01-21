import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class LocalStorageService {
  static const String tasksKey = 'tasks';
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((t) => jsonEncode(t.toMap())).toList();
    await prefs.setStringList(tasksKey, tasksJson);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(tasksKey) ?? [];
    return tasksJson.map((t) => Task.fromMap(jsonDecode(t))).toList();
  }
}
