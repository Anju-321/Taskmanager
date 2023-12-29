import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/provider/taskprovider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return Dismissible(
                key: Key(task.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.green,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
               
                onDismissed: (direction) {
                  taskProvider.flutterTts.speak("task completed");                  
                    taskProvider.deleteTask(task.id);
                  
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      taskProvider.flutterTts.speak(task.title);
                    },
                   
                  title: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Customize text color
                      ),
                    ),
                    tileColor: Colors.grey[400], // Customize tile background color
                    contentPadding: const EdgeInsets.all(10.0), // Adjust content padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Add rounded corners
                    ),
                  ),
                ), 
                  
                
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false)
                .showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

//   void _showAddTaskDialog(BuildContext context) {
//     TextEditingController titleController = TextEditingController();
//     debugPrint(titleController.toString());

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add Task'),
//           content: TextField(
//             controller: titleController,
//             decoration: const InputDecoration(labelText: 'Task Title'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (titleController.text.isNotEmpty) {
//                   Provider.of<TaskProvider>(context, listen: false)
//                       .addTask(titleController.text);
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
}
