import 'package:flutter/material.dart';
import 'package:real_world_projects/data/services/network_caller.dart';
import 'package:real_world_projects/data/utility/urls.dart';
import 'package:real_world_projects/presentation/utils/app_color.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';

import '../../../data/models/response_object.dart';
import '../../widgets/snack_bar_massage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
                    height: 60,
                  ),
                  Text('Join With Us',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    controller: _firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    controller: _lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                    controller: _mobileNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Enter your mobile number',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length <= 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isLoading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _signUp();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
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
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.themeColor,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Sign In'),
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

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'email': _emailController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'mobile': _mobileNumberController.text.trim(),
        'password': _passwordController.text,
      };
      final ResponseObject response =
          await NetworkCaller.postRequest(Urls.registration, userData);
      setState(() {
        _isLoading = false;
      });
      if (response.isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Registration Successful');
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, 'Registration Failed', true);
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
