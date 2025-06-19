// lib/custom_drawer.dart

import 'package:flutter/material.dart';
import 'task_model.dart';
import 'completed_screen.dart';
import 'deleted_screen.dart';
import 'important_screen.dart';


class CustomDrawer extends StatelessWidget {
  final List<Task> completedTasks;
  final List<Task> deletedTasks;
  final List<Task> starredTasks;

  const CustomDrawer({
    super.key,
    required this.completedTasks,
    required this.deletedTasks,
    required this.starredTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          _drawerHeader(title: "Menu"),
          _drawerTile(context, Icons.check_circle_outline, 'Completed Tasks', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CompletedScreen(completedTasks: completedTasks),
              ),
            );
          }),
          _drawerTile(context, Icons.star_border, 'Important Tasks', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImportantScreen(importantTasks: starredTasks),
              ),
            );
          }),
          _drawerTile(context, Icons.delete_outline, 'Deleted Tasks', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DeletedScreen(deletedTasks: deletedTasks),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _drawerHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _drawerTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
