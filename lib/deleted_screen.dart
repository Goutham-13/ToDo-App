import 'package:flutter/material.dart';
import 'task_model.dart';

class DeletedScreen extends StatelessWidget {
  final List<Task> deletedTasks;
  const DeletedScreen({super.key, required this.deletedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deleted Tasks')),
      body: deletedTasks.isEmpty
          ? const Center(child: Text('No deleted tasks yet!'))
          : ListView.builder(
              itemCount: deletedTasks.length,
              itemBuilder: (context, index) {
                final task = deletedTasks[index];
                return ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    task.title,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
