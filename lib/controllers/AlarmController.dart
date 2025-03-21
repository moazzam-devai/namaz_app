import 'dart:convert';

import 'package:al_khair/Model/alarm_Model.dart';
import 'package:al_khair/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmController extends GetxController {
  late SharedPreferences preferences;

  RxList<Model> modelist = <Model>[].obs;
  List<String> listofstring = [];
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  late BuildContext context;

  // Add an alarm to the list
  void setAlarm(String label, String dateTime, bool check, String repeat,
      int id, int milliseconds) {
    modelist.add(Model(
        label: label,
        dateTime: dateTime,
        check: check,
        when: repeat,
        id: id,
        milliseconds: milliseconds));
  }

  // Edit the switch status of an alarm
  void editSwitch(int index, bool check) {
    modelist[index].check = check;
  }

  // Get saved data from SharedPreferences
  Future<void> getData() async {
    preferences = await SharedPreferences.getInstance();
    List<String>? comingList = preferences.getStringList("data");

    if (comingList != null) {
      modelist.value =
          comingList.map((e) => Model.fromJson(json.decode(e))).toList();
    }
  }

  // Save data to SharedPreferences
  void setData() {
    listofstring = modelist.map((e) => json.encode(e.toJson())).toList();
    preferences.setStringList("data", listofstring);
  }

  // Initialize the notifications
  Future<void> initialize(BuildContext con) async {
    context = con;
    var androidInitilize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Initialize notifications
    await flutterLocalNotificationsPlugin!.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    // Request iOS permissions for notifications
    flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // Notification response handler
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(context,
        MaterialPageRoute<void>(builder: (context) => const HomeScreen()));
  }

  // Show a simple notification
  Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin!.show(
      0,
      'plain title',
      'plain body',
      notificationDetails,
      payload: 'item x',
    );
  }

  // Schedule a notification
  Future<void> scheduleNotification(DateTime dateTime, int randomNumber) async {
    int newTime =
        dateTime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;

    await flutterLocalNotificationsPlugin!.zonedSchedule(
      randomNumber,
      'Alarm Clock',
      DateFormat().format(DateTime.now()),
      tz.TZDateTime.now(tz.local).add(Duration(milliseconds: newTime)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          sound: RawResourceAndroidNotificationSound("alarm"),
          autoCancel: false,
          playSound: true,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(
          sound: 'alarm.mp3',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Cancel a scheduled notification
  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin!.cancel(notificationId);
  }
}
