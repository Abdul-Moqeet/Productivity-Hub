class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final DateTime endDate;
  final String priority;
  final task_type;
  bool isCompleted; 

  Task({
    this.id = 's',
    required this.endDate,
    required this.task_type,
    required this.title,
    required this.description,
    required this.dueDate,
    this.priority = 's',
    this.isCompleted = false,
  });
}