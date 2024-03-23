import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/screens/auth/set_password_screen.dart';
import 'package:real_world_projects/presentation/screens/auth/sign_in_screen.dart';
import 'package:real_world_projects/presentation/utils/app_color.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../data/services/network_caller.dart';
import '../../../data/utility/urls.dart';
import '../../widgets/snack_bar_massage.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _pinVerificationInProgress = false;

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
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Enter the pin sent to your email address',
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
                  PinCodeTextField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter the pin';
                      }
                      return null;
                    },
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                    appContext: context,
                    length: 6,
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    backgroundColor: Colors.transparent,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: AppColors.themeColor,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _pinVerificationInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isPinValid = await checkPinCode(
                                'email', int.parse(_pinController.text));
                            if (isPinValid) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SetPasswordScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          }
                        },
                        child: const Text('Verify'),
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

Future<bool> checkPinCode(String email, int otp) async {
  _pinVerificationInProgress = true;
  setState(() {});
  final response = await NetworkCaller.getRequest(Urls.verifyPinCode(email, otp));
  _pinVerificationInProgress = false;
  setState(() {});
  if (response.isSuccess) {
    return true;
  } else {
    if (mounted) {
      showSnackBarMessage(context, 'Pin verification has been failed', true);
    }
    return false;
  }
}
  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
