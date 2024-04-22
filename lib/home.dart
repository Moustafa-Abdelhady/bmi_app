import 'package:bmi_app/authantication/login_page.dart';
import 'package:bmi_app/bmi_history.dart';
import 'package:bmi_app/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import '../constants.dart';

import 'dart:math';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  bool isMale = true;
  double height = 120.0;
  int weight = 50;
  int age = 18;
  double result = 0;

  @override
  Widget build(BuildContext context) {
    var mail = FirebaseAuth.instance.currentUser!.email;

    uploadResult(
      String email,
      bool isMale,
      int age,
      double result,
    ) async {
      String uId = const Uuid().v1();
      await FirebaseFirestore.instance.collection('bmi_history').add({
        'id': uId,
        'email': email,
        'isMale': isMale,
        'age': age,
        'result': result,
        'date': DateTime.now().toString().substring(0, 16),
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const BmiHistory();
                }),
              );
            },
            icon: const Icon(Icons.history)),
        title: Text(
          'BMI',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: titlesColor,
              ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              setState(() {});
              Future.delayed(const Duration(milliseconds: 3), () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    firstExpanded(context, 'Female'),
                    Gap(8),
                    firstExpanded(context, 'Male'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HEIGHT',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${height.round()}',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'CM',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: height,
                        min: 80.0,
                        max: 220.0,
                        onChanged: (val) {
                          setState(() {
                            height = val;
                          });
                        },
                        activeColor: Colors.blueGrey[800],
                        inactiveColor: Colors.blueGrey[600],
                        thumbColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    thirdExpanded(context, 'weight'),
                    const Gap(8),
                    thirdExpanded(context, 'age'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
              ),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: MaterialButton(
                  //height: MediaQuery.of(context).size.height / 12,
                  child: Text(
                    'CALCULATE',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: titlesColor,
                        ),
                  ),
                  onPressed: () {
                    result = weight / pow(height / 100, 2);

                    uploadResult(mail!, isMale, age, result);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return BmiResultScreen(
                          result: result,
                          age: age,
                          isMale: isMale,
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstExpanded(BuildContext context, String gender) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = (gender == 'Male') ? true : false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                (isMale && gender == 'Male') || (!isMale && gender == 'Female')
                    ? defaultColor
                    : Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  gender == 'Male'
                      ? 'assets/images/male.png'
                      : 'assets/images/female.png',
                ),
                height: 90,
                width: 90,
              ),
              const Gap(8),
              Text(
                (gender == 'Male') ? 'Male' : 'FEMALE',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget thirdExpanded(BuildContext context, String title) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Gap(8),
            Text(
              (title == 'weight') ? '$weight' : '$age',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (title == 'weight' && weight > 0) {
                        weight--;
                      } else if (title == 'age' && age > 0) {
                        age--;
                      }
                    });
                  },
                  heroTag: (title == 'weight') ? 'weight--' : 'age--',
                  // There are multiple heroes that share the same tag within a subtree.
                  // المفروض يكون في زرار واحد فلوتينج ف بدي لكل واحد زي اسم كدا عشان افرقهم عن بعض

                  mini: true,
                  // size (mini , normal)
                  backgroundColor: defaultColor,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                ),
                const Gap(20),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (title == 'weight') {
                        weight++;
                      } else {
                        age++;
                      }
                    });
                  },
                  heroTag: (title == 'weight') ? 'weight++' : 'age++',
                  // There are multiple heroes that share the same tag within a subtree.
                  // المفروض يكون في زرار واحد فلوتينج ف بدي لكل واحد زي اسم كدا عشان افرقهم عن بعض

                  mini: true,
                  // size (mini , normal)
                  backgroundColor: defaultColor,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
