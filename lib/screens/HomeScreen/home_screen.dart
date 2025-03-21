import 'dart:async';

import 'package:al_khair/controllers/AlarmController.dart';
import 'package:al_khair/controllers/time_controller.dart';
import 'package:al_khair/widgets/prayer_info.dart';
import 'package:al_khair/widgets/time_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwitched = false;
  bool value = false;

  @override
  void initState() {
    super.initState();
    // Initialize GetX controller and fetch data
    Get.put(AlarmController()).initialize(context);
    Get.find<AlarmController>().getData();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TimeController());

    Widget buildText(String text,
        {double fontSize = 18,
        Color color = Colors.white,
        FontWeight weight = FontWeight.bold}) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'Poppins',
          fontWeight: weight,
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Color(0xFF222933)),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              child: Image.asset('assets/images/image.png',
                  fit: BoxFit.cover, height: 230),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: Container(
              height: 193,
              decoration: BoxDecoration(
                color: Color(0xFF1F2429),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 161,
                      width: 190,
                      decoration: BoxDecoration(
                        color: Color(0xFF2F333D),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.all(8),
                      child: PrayerInfo(),
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/sun.png',
                            height: 90, width: 138),
                        TimeDisplay(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 370,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                {'image': 'namaz.png', 'text': 'Namaz'},
                {'image': 'dir.png', 'text': 'Direction'},
                {'image': 'alram.png', 'text': 'Reminder'},
              ]
                  .map((item) => Column(
                        children: [
                          Image.asset('assets/images/${item['image']}',
                              height: 120, width: 120, fit: BoxFit.cover),
                          buildText(item['text']!, fontSize: 18),
                        ],
                      ))
                  .toList(),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/me.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Muhammad Ali',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            top: 500,
            left: 10,
            right: 10,
            child: SizedBox(
              height: 370,
              child: GetX<AlarmController>(
                builder: (controller) {
                  return ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                          itemCount: controller.modelist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF1F2429),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller
                                                .modelist[index].dateTime!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFFFFDB6B),
                                            ),
                                          ),
                                          CupertinoSwitch(
                                            activeTrackColor: Color(0xFFFFDB6B),
                                            value: (controller.modelist[index]
                                                        .milliseconds! <
                                                    DateTime.now()
                                                        .microsecondsSinceEpoch)
                                                ? false
                                                : controller
                                                    .modelist[index].check,
                                            onChanged: (v) {
                                              controller.editSwitch(index, v);
                                              controller.cancelNotification(
                                                  controller
                                                      .modelist[index].id!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
