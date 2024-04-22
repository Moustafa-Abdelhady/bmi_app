import 'package:bmi_app/pages/authantication/login_page.dart';
import 'package:bmi_app/constants.dart';
import 'package:bmi_app/pages/home.dart';
import 'package:bmi_app/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: titlesColor),
              hintStyle: TextStyle(color: mainTitleColor),
              prefixIconColor: mainTitleColor),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: mainTitleColor),
          primaryColor: mainTitleColor,
          hintColor: mainTitleColor,
          appBarTheme: AppBarTheme(surfaceTintColor: mainTitleColor)),

      // make stream builder to check if user has logedin makes him going to homepage
      //and if he new in app makes him going to login page
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BmiCalculator();
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
