import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/cancelled_task_screen.dart';
import 'package:real_world_projects/presentation/screens/complete_task_screen.dart';
import 'package:real_world_projects/presentation/screens/new_task_screen.dart';
import 'package:real_world_projects/presentation/screens/progress_task_screen.dart';
import 'package:real_world_projects/presentation/utils/app_color.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int currentTab = 0;

  List<Widget> tabs = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const ProgressTaskScreen(),
    const CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(
            () {
              currentTab = index;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined),
            label: 'New Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline_outlined),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel), label: 'Cancelled Task'),
        ],
      ),
    );
  }
}
