import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';

import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
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
