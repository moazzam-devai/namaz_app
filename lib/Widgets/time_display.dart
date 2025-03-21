import 'package:al_khair/controllers/time_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final TimeController timeController = Get.find();

    Widget buildRichText() {
      return Obx(() => RichText(
            text: TextSpan(
              text: timeController.currentTime.value,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: " "),
                TextSpan(
                  text: timeController.amPm.value,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFFFDB6B),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ));
    }

    Widget buildIslamicDate() {
      return Obx(() => Text(
            timeController.currentIslamicDate.value,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFDB6B),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ));
    }

    return Column(
      children: [
        buildRichText(),
        buildIslamicDate(),
      ],
    );
  }
}
