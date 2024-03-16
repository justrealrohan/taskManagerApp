import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Task Manager',
      home: Splash_Screen(),
    );
  }
}
