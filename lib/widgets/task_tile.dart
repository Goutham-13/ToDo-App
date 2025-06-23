import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(String) onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter new task name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6F00)),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onEdit(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget animatedIconButton({required IconData icon, required VoidCallback onTap, required Key key}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: FadeTransition(opacity: animation, child: child)),
      child: IconButton(
        key: key,
        icon: Icon(icon, color: Colors.black87),
        onPressed: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: GestureDetector(
            onTap: onToggle,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: FadeTransition(opacity: animation, child: child)),
              child: task.isDone
                  ? const Icon(Icons.check_circle, key: ValueKey('checked'), color: Color(0xFFFF6F00))
                  : const Icon(Icons.radio_button_unchecked, key: ValueKey('unchecked'), color: Colors.grey),
            ),
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 16,
              color: task.isDone ? Colors.grey : Colors.black,
              decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            ),
            child: Text(task.title),
          ),
          trailing: Wrap(
            spacing: 0,
            children: [
              animatedIconButton(
                icon: Icons.edit_outlined,
                onTap: () => _showEditDialog(context),
                key: const ValueKey('edit'),
              ),
              animatedIconButton(
                icon: Icons.delete_outline,
                onTap: onDelete,
                key: const ValueKey('delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
