// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterdemo/Provider/transaction_provider.dart';
import 'package:flutterdemo/models/data.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentStep = 0;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final houseNumber = TextEditingController();
  final group = TextEditingController();
  final supDistrict = TextEditingController();
  final district = TextEditingController();
  final province = TextEditingController();

  coutinueStep() {
    if (currentStep < 2) {
      if (currentStep == 1) {
        var first_name = firstName.text;
        var last_name = lastName.text;
        var house_number = houseNumber.text;
        var group1 = group.text;
        var sup_district = supDistrict.text;
        var district1 = district.text;
        var province1 = province.text;
        Transaction statement = Transaction(
            firstName: first_name,
            lastName: last_name,
            houseNumber: house_number,
            group: group1,
            supDistrict: sup_district,
            district: district1,
            province: province1);
        var provider1 =
            Provider.of<TransactionProvider>(context, listen: false);
        provider1.addTransaction(statement);
      }

      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlBuilder(context, details) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: details.onStepContinue,
          child: Text('Next'),
        ),
        SizedBox(
          width: 10,
        ),
        OutlinedButton(onPressed: details.onStepCancel, child: Text('Back'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Sample'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'เพิ่มรายชื่อ',
                icon: Icon(Icons.add),
              ),
              Tab(
                text: 'ข้อมูล',
                icon: Icon(Icons.dehaze_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Stepper(
                currentStep: currentStep,
                onStepContinue: coutinueStep,
                onStepCancel: cancelStep,
                onStepTapped: onStepTapped,
                controlsBuilder: controlBuilder,
                steps: [
                  Step(
                      title: const Text('Step1'),
                      content: Column(
                        children: [
                          TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(labelText: 'ชื่อ'),
                          ),
                          TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(labelText: 'นามสกุล'),
                          )
                        ],
                      ),
                      isActive: currentStep >= 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const Text('Step2'),
                      content: Column(
                        children: [
                          TextFormField(
                            controller: houseNumber,
                            decoration:
                                InputDecoration(labelText: 'บ้านเลขที่'),
                          ),
                          TextFormField(
                            controller: group,
                            decoration: InputDecoration(labelText: 'หมู่ที่'),
                          ),
                          TextFormField(
                            controller: supDistrict,
                            decoration: InputDecoration(labelText: 'ตำบล'),
                          ),
                          TextFormField(
                            controller: district,
                            decoration: InputDecoration(labelText: 'อำเภอ'),
                          ),
                          TextFormField(
                            controller: province,
                            decoration: InputDecoration(labelText: 'จังหวัด'),
                          ),
                        ],
                      ),
                      isActive: currentStep >= 1,
                      state: StepState.complete),
                  Step(
                      title: const Text('confirm'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'ชื่อ:${firstName.text}',
                          ),
                          Text('นามสกุล:${lastName.text}')
                        ],
                      ),
                      isActive: currentStep >= 2,
                      state: StepState.complete),
                ]),
            Consumer<TransactionProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                    itemCount: provider.transactions.length,
                    itemBuilder: (context, int index) {
                      Transaction data = provider.transactions[index];
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('ชื่อ::' + data.firstName),
                                  IconButton(
                                      onPressed: provider.deleteTransaction,
                                      icon: Icon(Icons.delete_forever_rounded))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('นามสกุล::' + data.lastName),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('บ้านเลขที่::' + data.houseNumber),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text('หมู่ที่::' + data.group),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text('ตำบล::' + data.supDistrict),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('อำเภอ::' + data.district),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text('จังหวัด::' + data.province),
                                  SizedBox(
                                    width: 150,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
