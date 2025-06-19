import 'package:flutter/material.dart';
import 'task_model.dart';
import 'completed_screen.dart';
import 'deleted_screen.dart';
import 'important_screen.dart';
import 'custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];
  final List<Task> _deletedTasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter your task'),
          onSubmitted: (_) => _handleAddTask(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _handleAddTask,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _handleAddTask() {
    String input = _controller.text.trim();
    if (input.isNotEmpty) {
      final newTask = Task(title: input);
      setState(() {
        _tasks.insert(0, newTask);
      });
      _controller.clear();
      Navigator.pop(context);
    }
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _toggleStar(Task task) {
    setState(() {
      task.isStarred = !task.isStarred;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
      _deletedTasks.insert(0, task);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildReorderableItem(Task task) {
    return Container(
      key: ValueKey(task), // This is crucial for ReorderableListView
      child: Dismissible(
        key: UniqueKey(), // For swipe to delete
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => _deleteTask(task),
        child: ListTile(
          leading: Checkbox(
            value: task.isDone,
            onChanged: (_) => _toggleTask(task),
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: task.isDone
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 18,
                  )
                : const TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 18,
                  ),
            child: Text(task.title),
          ),
          trailing: IconButton(
            icon: Icon(
              task.isStarred ? Icons.star : Icons.star_border,
              color: task.isStarred ? Colors.orange : Colors.grey,
            ),
            onPressed: () => _toggleStar(task),
          ),
        ),
      ),
    );
  }

  List<Task> get _completedTasks => _tasks.where((task) => task.isDone).toList();
  List<Task> get _starredTasks =>
      _tasks.where((task) => task.isStarred && !_deletedTasks.contains(task)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      drawer: CustomDrawer(
  completedTasks: _completedTasks,
  deletedTasks: _deletedTasks,
  tasks: _tasks, // This now matches the constructor
),

      body: _tasks.isEmpty
          ? const Center(child: Text("No tasks. Tap + to add one!", style: TextStyle(fontSize: 18)))
          : ReorderableListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              buildDefaultDragHandles: false, // Use long press instead
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final task = _tasks.removeAt(oldIndex);
                  _tasks.insert(newIndex, task);
                });
              },
              children: _tasks.map((task) {
                return GestureDetector(
                  key: ValueKey(task),
                  onLongPress: () {
                    // Reorder handled automatically by ReorderableListView
                  },
                  child: _buildReorderableItem(task),
                );
              }).toList(),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 50.0),
        child: FloatingActionButton(
          onPressed: _addTaskDialog,
          backgroundColor: Colors.orange,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
