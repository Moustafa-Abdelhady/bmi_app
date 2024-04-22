import 'package:bmi_app/constants.dart';
import 'package:bmi_app/widgets/bmi_history_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BmiHistory extends StatefulWidget {
  const BmiHistory({super.key});

  @override
  State<BmiHistory> createState() => _BmiHistoryState();
}

class _BmiHistoryState extends State<BmiHistory> {
  Stream<QuerySnapshot> bmiStream = FirebaseFirestore.instance
      .collection('bmi_history')
      .orderBy('date', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI History',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: titlesColor,
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: bmiStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    dynamic bmiHis = snapshot.data;
                    return ListView.builder(
                      itemCount: bmiHis.docs.length,
                      itemBuilder: (context, index) {
                        dynamic data = bmiHis.docs[index];
                        return Dismissible(
                          confirmDismiss: (DismissDirection direction) async {
                            var docRef = FirebaseFirestore.instance
                                .collection('bmi_history')
                                .doc(data.id);
                            await docRef.delete();
                            setState(() {});
                            return true;
                            // if (direction == DismissDirection.startToEnd) {

                            // }
                          },
                          background: Container(
                            color: Colors.red,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  'Delete',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          // secondaryBackground: ,
                          key: ValueKey<dynamic>(data),
                          child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  ShowHistory(
                                      mail: data['email'],
                                      date: data['date'].toString(),
                                      age: data['age'].toString(),
                                      gender: data['isMale'].toString(),
                                      res: data['result'].toStringAsFixed(1))
                                ],
                              )),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
