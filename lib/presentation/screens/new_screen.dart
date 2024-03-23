import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/task_screen.dart';

import '../../data/utility/urls.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskScreen(
      title: 'New Tasks',
      url: Urls.newTaskList,
    );
  }
}