import 'package:bmi_app/constants.dart';
import 'package:bmi_app/pages/authantication/login_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/images/OIP.png',
      ),
      logoWidth: MediaQuery.of(context).size.width * 0.4,
      title: const Text(
        "BMI Calculator",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: mainTitleColor,
      showLoader: true,
      navigator: const LoginPage(),
      durationInSeconds: 5,
    );
  }
}
