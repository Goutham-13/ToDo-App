import 'package:flutter/material.dart';
import 'task_model.dart';

class ImportantScreen extends StatelessWidget {
  final List<Task> importantTasks;

  const ImportantScreen({super.key, required this.importantTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Important Tasks'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: importantTasks.isEmpty
          ? const Center(
              child: Text(
                'No important tasks yet!',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: importantTasks.length,
              itemBuilder: (context, index) {
                final task = importantTasks[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: null, // Tasks are view-only in this screen
                      checkColor: Colors.white,
                      activeColor: Colors.orange,
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        color: task.isDone ? Colors.grey : Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(Icons.star, color: Colors.orange),
                  ),
                );
              },
            ),
    );
  }
}
