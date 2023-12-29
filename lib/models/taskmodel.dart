class Task {
  final String id;
  final String title;

  Task({required this.id, required this.title});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory Task.fromJson(Map<String, dynamic> taskData) {
    return Task(id: taskData['id'], title: taskData['title']);
  }
}
