import 'dart:convert';

import 'package:al_khair/Model/hadees_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HadithController extends GetxController {
  Rx<HadithResponse?> hadithResponse = Rx<HadithResponse?>(null);
  RxBool isEnglish = true.obs;
  RxBool showFab = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchHadithData();
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    super.onClose();
  }

  void scrollListener() {
    if (scrollController.offset > 300) {
      if (!showFab.value) {
        showFab.value = true;
      }
    } else {
      if (showFab.value) {
        showFab.value = false;
      }
    }
  }

  Future<void> fetchHadithData() async {
    final String apiUrl = 'https://hadithapi.com/api/hadiths';
    final String apiKey =
        r'$2y$10$zymPQMwUZ8msHTpts6Ot4uaQdWo9HOEAQoaI7dYBjWpl6OE0PgTy';

    final response = await http.get(Uri.parse('$apiUrl?apiKey=$apiKey'));

    if (response.statusCode == 200) {
      hadithResponse.value = HadithResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load data');
      hadithResponse.value = null;
    }
  }

  void toggleLanguage() {
    print("Before Toggle: ${isEnglish.value}");
    isEnglish.value = !isEnglish.value;
    update();
    print("After Toggle: ${isEnglish.value}");
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
