import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';

import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileBar,
      body: backgroundImage(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return const TaskCard();
          },
        ),
      ),
    );
  }
}
