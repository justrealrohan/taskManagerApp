import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/add_new_task_screen.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';

import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  Widget taskCounterSection() {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const TaskCounterCard(
              title: 'New',
              count: 12,
            );
          },
          separatorBuilder: (__, ___) => const SizedBox(
            height: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileBar,
      body: backgroundImage(
        child: Column(
          children: [
            taskCounterSection(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return const TaskCard();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
