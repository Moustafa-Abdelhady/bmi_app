// import 'package:flutter/foundation.dart';
import 'package:bmi_app/authantication/register_page.dart';
import 'package:bmi_app/constants.dart';
import 'package:bmi_app/home.dart';
import 'package:bmi_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

// import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  signIn() async {
    try {
      String loginRes = await AuthMethods()
          .signIn(email: emailCont.text, password: passwordCont.text);
      SnackBar snackbar = SnackBar(
        content: Center(child: Text(loginRes.toString())),
      );
      if (loginRes == "Success") {
        const CircularProgressIndicator();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BmiCalculator()),
            (route) => false);
      } else if (loginRes == "Please enter all fields" || loginRes == null) {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/bmi.png',
                height: 300,
              ),
            ),
            const Gap(15),
            TextField(
              controller: emailCont,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                fillColor: defaultColor,
                filled: true,
                prefixIcon: const Icon(Icons.email),
                hintText: 'Enter Mail',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: titlesColor),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const Gap(20),
            TextField(
              controller: passwordCont,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                fillColor: defaultColor,
                filled: true,
                prefixIcon: const Icon(Icons.password),
                hintText: 'Enter Password',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: titlesColor),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const Gap(200),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: defaultColor,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    if (emailCont.text.isEmpty ||
                        emailCont.text.contains('@') &
                            passwordCont.text.isEmpty ||
                        passwordCont.text.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                            child: Text(
                                'Please enter an valid Mail and password')),
                      ));
                    } else {
                      signIn();
                    }
                  },
                  child: Text(
                    'login'.toUpperCase(),
                    style: TextStyle(color: titlesColor),
                  ),
                ),
              )
            ]),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dont have an account?',
                ),
                const Gap(15),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                      (route) => false),
                  child: Text(
                    'Register  ',
                    style: TextStyle(
                        color: defaultColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
