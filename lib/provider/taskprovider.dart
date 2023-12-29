// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:taskmanager/models/taskmodel.dart';

// class TaskProvider extends ChangeNotifier {
//   List<Task> _tasks = [];

//   List<Task> get tasks => _tasks;
//   FlutterTts flutterTts = FlutterTts();



//   void addTask(String title) {
//     _tasks.insert(0, Task(id: DateTime.now().toString(), title: title));
//     notifyListeners();
//   }

//   void deleteTask(String taskId) {
//     _tasks.removeWhere((task) => task.id == taskId);
//     notifyListeners();
//   }

  
//   void showAddTaskDialog(BuildContext context) {
//   TextEditingController titleController = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Builder(
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Add Task'),
//             content: TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'Task Title'),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   if (titleController.text.isNotEmpty) {
                   
//                         addTask(titleController.text);
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 child: const Text('Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }

// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/models/taskmodel.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  FlutterTts flutterTts = FlutterTts();
  static const String _tasksKey = 'tasks';

  List<Task> get tasks => _tasks;

  TaskProvider() {
    // Load tasks from local storage when the provider is created
    _loadTasks();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksJson = prefs.getString(_tasksKey) ?? '[]';
    List<dynamic> decodedTasks = jsonDecode(tasksJson);
    _tasks = decodedTasks.map((task) => Task.fromJson(task)).toList();
    notifyListeners();
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksJson = jsonEncode(_tasks);
    prefs.setString(_tasksKey, tasksJson);
  }

  void addTask(String title) {
    _tasks.insert(0, Task(id: DateTime.now().toString(), title: title));
    _saveTasks(); // Save tasks after adding a new one
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    _saveTasks(); // Save tasks after deleting one
    notifyListeners();
  }

   void showAddTaskDialog(BuildContext context) {
  TextEditingController titleController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Builder(
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                   
                        addTask(titleController.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}
}
