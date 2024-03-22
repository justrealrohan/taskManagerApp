import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/task_screen.dart';

import '../../data/utility/urls.dart';
class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskScreen(
      title: 'Completed Tasks',
      url: Urls.completedTaskList,
    );
  }
}