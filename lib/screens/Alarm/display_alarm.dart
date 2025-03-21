// import 'dart:async';

// import 'package:al_khair/controllers/AlarmController.dart';
// import 'package:al_khair/screens/Alarm/Add_Alarm.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:timezone/data/latest_all.dart' as tz;

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   tz.initializeTimeZones();

//   // Initialize the FlutterLocalNotificationsPlugin
//   await flutterLocalNotificationsPlugin.initialize(
//     InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     ),
//     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//   );

//   // Request iOS notification permission
//   flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>()
//       ?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );

//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const DisplayArlam(),
//     ),
//   );
// }

// void onDidReceiveNotificationResponse(
//     NotificationResponse notificationResponse) {
//   final String? payload = notificationResponse.payload;
//   if (payload != null) {
//     debugPrint('Notification Payload: $payload');
//   }
// }

// class DisplayArlam extends StatefulWidget {
//   const DisplayArlam({super.key});

//   @override
//   State<DisplayArlam> createState() => _DisplayArlamState();
// }

// class _DisplayArlamState extends State<DisplayArlam> {
//   bool value = false;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize GetX controller and fetch data
//     Get.put(AlarmController()).initialize(context);
//     Get.find<AlarmController>().getData();

//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEEEFF5),
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurpleAccent,
//         actions: const [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.menu,
//               color: Colors.white,
//             ),
//           )
//         ],
//         title: const Text(
//           'Alarm Clock',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: GetX<AlarmController>(
//         builder: (controller) {
//           return ListView(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.deepPurpleAccent,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//                 height: MediaQuery.of(context).size.height * 0.1,
//                 child: Center(
//                   child: Text(
//                     DateFormat.yMEd().add_jms().format(DateTime.now()),
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 child: ListView.builder(
//                   itemCount: controller.modelist.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         height: 110,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         controller.modelist[index].dateTime!,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 8.0),
//                                         child: Text(
//                                             "|${controller.modelist[index].label}"),
//                                       ),
//                                     ],
//                                   ),
//                                   CupertinoSwitch(
//                                     value: (controller
//                                                 .modelist[index].milliseconds! <
//                                             DateTime.now()
//                                                 .microsecondsSinceEpoch)
//                                         ? false
//                                         : controller.modelist[index].check,
//                                     onChanged: (v) {
//                                       controller.editSwitch(index, v);
//                                       controller.cancelNotification(
//                                           controller.modelist[index].id!);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Text(controller.modelist[index].when!),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.1,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   color: Colors.deepPurpleAccent,
//                 ),
//                 child: Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const AddAlarm()),
//                       );
//                     },
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Padding(
//                         padding: EdgeInsets.all(12.0),
//                         child: Icon(Icons.add),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
