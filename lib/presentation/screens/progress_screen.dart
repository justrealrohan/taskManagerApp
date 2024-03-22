import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/task_screen.dart';

import '../../data/utility/urls.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskScreen(
      title: 'Tasks in Progress',
      url: Urls.progressTaskList,
    );
  }
}