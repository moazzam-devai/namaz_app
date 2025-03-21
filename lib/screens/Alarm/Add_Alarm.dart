import 'dart:math';

import 'package:al_khair/controllers/AlarmController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _AddAlaramState();
}

class _AddAlaramState extends State<AddAlarm> {
  late TextEditingController controller;

  String? dateTime;
  bool repeat = false;

  DateTime? notificationtime;

  String? name = "none";
  int? Milliseconds;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222933),
      appBar: AppBar(
        backgroundColor: Color(0xFF222933),
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Alarm',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: CupertinoDatePicker(
              showDayOfWeek: true,
              minimumDate: DateTime.now(),
              dateOrder: DatePickerDateOrder.dmy,
              onDateTimeChanged: (va) {
                dateTime = DateFormat().add_jms().format(va);
                Milliseconds = va.microsecondsSinceEpoch;
                notificationtime = va;

                print(dateTime);
              },
            )),
          ),
          ElevatedButton(
            onPressed: () {
              Random random = Random();
              int randomNumber = random.nextInt(100);

              // Using GetX to call methods from the AlarmController
              Get.find<AlarmController>().setAlarm(controller.text, dateTime!,
                  true, name!, randomNumber, Milliseconds!);
              Get.find<AlarmController>().setData();

              Get.find<AlarmController>()
                  .scheduleNotification(notificationtime!, randomNumber);

              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Color(0xFFFFDB6B),
              ),
              foregroundColor: WidgetStateProperty.all(Colors.black),
            ),
            child: const Text("Set Alarm"),
          )
        ],
      ),
    );
  }
}
