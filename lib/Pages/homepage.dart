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
                  taskProvider.flutterTts.speak("${task.title} Completed ");                  
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
                        color: Colors.blue, 
                      ),
                    ),
                    tileColor: Colors.grey[400], 
                    contentPadding: const EdgeInsets.all(10.0), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), 
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
}
