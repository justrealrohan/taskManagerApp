import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_world_projects/presentation/screens/auth/sign_in_screen.dart';
import 'package:real_world_projects/presentation/utils/assets_path.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    _MoveToSignInScreen();
  }

  Future<void> _MoveToSignInScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundImage(
        child: Center(
          child: SvgPicture.asset(
            AssetsPath.logoSvg,
            width: 120,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
