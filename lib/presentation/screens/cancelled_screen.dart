import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/task_screen.dart';

import '../../data/utility/urls.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskScreen(
      title: 'Cancelled Tasks',
      url: Urls.cancelledTaskList,
    );
  }
}