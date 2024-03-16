import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/auth/splash_screen.dart';
import 'package:real_world_projects/presentation/utils/app_color.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      title: 'Task Manager',
      home: const Splash_Screen(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          labelStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.themeColor,
            textStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.themeColor.withOpacity(0.1),
          labelStyle: const TextStyle(
            color: AppColors.themeColor,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
