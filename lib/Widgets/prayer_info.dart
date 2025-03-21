import 'package:al_khair/controllers/time_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrayerInfo extends StatelessWidget {
  const PrayerInfo({super.key});
  String _capitalizeFirstWord(String text) {
    if (text.isEmpty) return text;
    List<String> words = text.split(' ');
    if (words.isNotEmpty) {
      words[0] = '${words[0][0].toUpperCase()}${words[0].substring(1)}';
    }
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final TimeController timeController = Get.find();

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => buildText(
              'Now : ${_capitalizeFirstWord(timeController.currentPrayer.value)}',
              fontSize: 22,
              color: Color(0xFFFFDB6B),
            )),
        buildText('Upcoming Namaz', fontSize: 13),
        Obx(() => buildText(
              'At : ${timeController.nextPrayerTime.value}',
              fontSize: 13,
            )),
        Obx(() => buildText(
              _capitalizeFirstWord(timeController.nextPrayer.value),
              fontSize: 22,
              color: Color(0xFFFFDB6B),
            )),
        buildText('Remaining Time', fontSize: 13),
        Obx(() => buildText(
              timeController.remainingTime.value,
              fontSize: 18,
              color: Color(0xFFFFDB6B),
            )),
      ],
    );
  }
}
