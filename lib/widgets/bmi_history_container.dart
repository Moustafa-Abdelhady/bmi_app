import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants.dart';

class ShowHistory extends StatelessWidget {
  const ShowHistory(
      {super.key,
      required this.mail,
      required this.res,
      required this.date,
      required this.age,
      required this.gender});
  final String mail;
  final String date;
  final String age;
  final String gender;
  final String res;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Mail',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Text(
                  mail,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(8),
                    Text(
                      date,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Text(
                  gender,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      'Age',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(8),
                    Text(
                      age,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Result',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Text(
                  res,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}
