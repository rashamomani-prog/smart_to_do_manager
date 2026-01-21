void main() {
  Task task1 = Task(
    title: 'Finish homework',
    description: 'Smart To-Do Manager assignment',
    priority: Priority.high,
    dueDate: DateTime.now(),
  );

  Task task2 = Task(
    title: 'Clean room',
    priority: Priority.low,
    dueDate: DateTime.now(),
  );

  Task task3 = Task(
    title: 'Buy groceries',
    priority: Priority.medium,
    dueDate: DateTime.now(),
  );

  List<Task> tasks = [task1, task2, task3];
}
enum Priority { low, medium, high }
class Task {
  String title;
  String? description;
  Priority priority;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.title,
    this.description,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority.name,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      priority: Priority.values.byName(map['priority']),
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'],
    );
  }
}
