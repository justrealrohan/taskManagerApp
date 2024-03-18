import 'package:flutter/material.dart';
import 'package:real_world_projects/app.dart';
import 'package:real_world_projects/presentation/controllers/auth_controller.dart';
import 'package:real_world_projects/presentation/screens/auth/sign_in_screen.dart';
import 'package:real_world_projects/presentation/screens/profile_screen.dart'; // Import the ProfileScreen

import '../utils/app_color.dart';

PreferredSizeWidget get ProfileBar {
  return PreferredSize(
    preferredSize:
        const Size.fromHeight(kToolbarHeight), // Set the height of the AppBar
    child: GestureDetector(
      onTap: () {
        if (ModalRoute.of(TaskManager.navigatorKey.currentState!.context)!
                .settings
                .name !=
            '/profile') {
          Navigator.push(
            TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) =>
                    const ProfileScreen()), // Navigate to ProfileScreen
          );
        }
      },
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rabbil Hasan',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'rabbil@gmail.com',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                    TaskManager.navigatorKey.currentState!.context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (route) => false);
              },
              style: IconButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    ),
  );
}
