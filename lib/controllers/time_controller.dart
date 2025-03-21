import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/jhijri.dart'; // Import jhijri package

class TimeController extends GetxController {
  var currentTime = ''.obs;
  var amPm = ''.obs;
  var currentDate = ''.obs;
  var isIslamic = false.obs;
  var currentIslamicDate = ''.obs;
  var currentPrayer = ''.obs;
  var nextPrayer = ''.obs;
  var nextPrayerTime = ''.obs;
  var remainingTime = ''.obs; // Observable for remaining time

  final List<String> arabicNumerals = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩'
  ];

  final List<String> arabicMonths = [
    'محرم',
    'صفر',
    'ربيع الأول',
    'ربيع الثاني',
    'جمادى الأول',
    'جمادى الثاني',
    'رجب',
    'شعبان',
    'رمضان',
    'شوّال',
    'ذو القعدة',
    'ذو الحجة'
  ];

  @override
  void onInit() {
    super.onInit();
    updateTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) => updateTime());
    Timer.periodic(Duration(minutes: 1),
        (Timer t) => updatePrayerTimes()); // Update prayer times every minute
    Timer.periodic(Duration(seconds: 4), (Timer t) => toggleDate());
    updatePrayerTimes();
  }

  void updateTime() {
    DateTime now = DateTime.now();
    currentTime.value = DateFormat('hh:mm:ss').format(now);
    amPm.value = DateFormat('a').format(now);
    currentDate.value = DateFormat('dd-MM-yyyy').format(now);

    var hijriDate = HijriDate.now();
    String arabicDay = _convertToArabicNumerals(hijriDate.day);
    String arabicMonth = arabicMonths[hijriDate.month - 1];
    String arabicYear = _convertToArabicNumerals(hijriDate.year);

    currentIslamicDate.value = '$arabicDay $arabicMonth $arabicYear';
  }

  String _convertToArabicNumerals(int number) {
    String numberString = number.toString();
    StringBuffer arabicNumber = StringBuffer();
    for (int i = 0; i < numberString.length; i++) {
      arabicNumber.write(arabicNumerals[int.parse(numberString[i])]);
    }
    return arabicNumber.toString();
  }

  void toggleDate() {
    isIslamic.value = !isIslamic.value;
  }

  // Method to update the prayer times
  void updatePrayerTimes() {
    final params =
        CalculationMethod.karachi.getParameters(); // Use Karachi method
    final coordinates = Coordinates(
        33.6844, 73.0479); // Example coordinates (Islamabad, Pakistan)

    final prayerTimes = PrayerTimes.today(coordinates, params);

    // Get the current time
    final now = DateTime.now();

    // Find the current prayer based on the current time
    Prayer? currentPrayerTime;
    for (var prayer in Prayer.values) {
      if (prayerTimes.timeForPrayer(prayer)?.isBefore(now) ?? false) {
        currentPrayerTime = prayer;
      }
    }

    if (currentPrayerTime != null) {
      currentPrayer.value = currentPrayerTime.name;
    }

    // Get the next prayer
    Prayer? nextPrayerTimeObject;
    for (var prayer in Prayer.values) {
      if (prayerTimes.timeForPrayer(prayer)?.isAfter(now) ?? false) {
        nextPrayerTimeObject = prayer;
        break;
      }
    }

    if (nextPrayerTimeObject != null) {
      nextPrayer.value = nextPrayerTimeObject.name;
      nextPrayerTime.value = DateFormat('hh:mm a')
          .format(prayerTimes.timeForPrayer(nextPrayerTimeObject)!);

      // Calculate the remaining time for the next prayer
      DateTime nextPrayerDateTime =
          prayerTimes.timeForPrayer(nextPrayerTimeObject)!;
      Duration remainingTimeDuration = nextPrayerDateTime.difference(now);

      // Calculate hours and minutes remaining
      int hoursRemaining = remainingTimeDuration.inHours;
      int minutesRemaining = remainingTimeDuration.inMinutes % 60;

      // Update the remainingTime observable
      String remainingTimeFormatted = '${hoursRemaining}h ${minutesRemaining}m';
      remainingTime.value = remainingTimeFormatted;
    }
  }
}
