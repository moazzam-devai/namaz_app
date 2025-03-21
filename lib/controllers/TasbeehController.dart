import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasbeehController extends GetxController {
  // Observable counter
  var counter = 0.obs;

  // Method to increment the counter
  void increment() {
    counter.value++;
  }

  // Method to reset the counter
  void reset() {
    counter.value = 0;
  }
}
