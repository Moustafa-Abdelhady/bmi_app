import 'package:bmi_app/authantication/login_page.dart';
import 'package:bmi_app/constants.dart';
import 'package:bmi_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  register() async {
    try {
      String response = await AuthMethods().signUp(
        email: emailCont.text,
        password: passwordCont.text,
        userName: userNameCont.text,
      );

      SnackBar snackbar = SnackBar(
        content: Center(child: Text(response.toString())),
      );

      if (response == "Success") {
        // ignore: use_build_context_synchronously
        return ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  @override
  void dispose() {
    userNameCont.text;
    emailCont.text;
    passwordCont.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/bmi.png',
                height: 300,
              ),
            ),
            const Gap(25),
            TextField(
              controller: userNameCont,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Username',
                fillColor: defaultColor,
                filled: true,
                prefixIcon: const Icon(Icons.contact_mail),
                hintText: 'Enter Username',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: titlesColor),
                    borderRadius: BorderRadius.circular(16)),
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
                    borderSide: BorderSide(color: mainTitleColor),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const Gap(15),
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
            const Gap(120),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: defaultColor,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    register();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: Text(
                    'Register'.toUpperCase(),
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
                  'already have an account?',
                ),
                const Gap(15),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false),
                  child: Text(
                    'Login',
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
