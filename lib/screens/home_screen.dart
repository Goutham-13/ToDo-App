import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask(String taskTitle) {
    if (taskTitle.trim().isEmpty) return;
    setState(() {
      _tasks.add(Task(title: taskTitle));
      _controller.clear();
    });
  }

  void _deleteTask(int index) {
    setState(() => _tasks.removeAt(index));
  }

  void _toggleTask(int index) {
    setState(() => _tasks[index].toggleDone());
  }

  void _editTask(int index, String newTitle) {
    setState(() => _tasks[index].title = newTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Input Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _addTask,
                    decoration: InputDecoration(
                      hintText: 'Add a new task',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6F00),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _addTask(_controller.text),
                  child: const Text('+', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Task List
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('No tasks yet.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) => TaskTile(
                        task: _tasks[index],
                        onToggle: () => _toggleTask(index),
                        onDelete: () => _deleteTask(index),
                        onEdit: (newTitle) => _editTask(index, newTitle),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
