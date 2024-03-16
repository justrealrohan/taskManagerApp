import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/auth/pin_verification_screen.dart';
import 'package:real_world_projects/presentation/screens/auth/sign_in_screen.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Create a password for your account',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter your new password',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _confirmNewPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      hintText: 'Enter your new password again',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PinVerificationScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                              (route) => false);
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }
}
