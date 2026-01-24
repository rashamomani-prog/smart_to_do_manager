class Task {
  int? id;
  String title;
  String? description;
  String priority;
  String dueDate;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority,
    'dueDate': dueDate,
    'isCompleted': isCompleted ? 1 : 0,
  };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    priority: map['priority'],
    dueDate: map['dueDate'],
    isCompleted: map['isCompleted'] == 1,
  );
}
