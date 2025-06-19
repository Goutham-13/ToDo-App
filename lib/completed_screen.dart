import 'package:flutter/material.dart';
import 'task_model.dart';

class CompletedScreen extends StatelessWidget {
  final List<Task> completedTasks;
  const CompletedScreen({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: completedTasks.isEmpty
          ? const Center(child: Text('No tasks completed yet!'))
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return ListTile(
                  leading: const Icon(Icons.check, color: Colors.green),
                  title: Text(
                    task.title,
                  ),
                );
              },
            ),
    );
  }
}
