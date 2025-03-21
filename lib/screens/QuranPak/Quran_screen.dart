import 'dart:convert';

import 'package:al_khair/Model/quran_model.dart';
import 'package:al_khair/controllers/Quran_controller.dart';
import 'package:al_khair/screens/QuranPak/SurahDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SurahController>(
      init: SurahController(), // Initialize the SurahController using GetX
      builder: (controller) {
        return Scaffold(
            backgroundColor: Color(0xFF222933),
            appBar: AppBar(
              backgroundColor: Color(0xFF222933),
              title: Text(
                'Quran Pak',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: FutureBuilder<QuranResponse>(
              future: fetchQuranData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        itemCount: 5,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Shimmer.fromColors(
                              baseColor: const Color.fromARGB(56, 255, 255, 255)
                                  .withOpacity(0.1),
                              highlightColor:
                                  const Color.fromARGB(52, 245, 245, 245),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Print error in terminal
                  print("Error: ${snapshot.error}");

                  // Show error message on the screen
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  var surahs = snapshot.data!.data.surahs;
                  return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: surahs.length,
                    itemBuilder: (context, index) {
                      var surah = surahs[index];
                      return Card(
                        color: Color(0xFF2F333D),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          title: Text(
                            surah.name,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            surah.englishNameTranslation,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing:
                              Icon(Icons.arrow_forward, color: Colors.white),
                          onTap: () {
                            Get.to(() => SurahDetailsScreen(surah: surah));
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No data found'));
                }
              },
            ));
      },
    );
  }

  Future<QuranResponse> fetchQuranData() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if data is already stored in SharedPreferences
    String? cachedData = prefs.getString('quran_data');

    if (cachedData != null) {
      // If data is found in SharedPreferences, return it
      print(
          "**************Loading Quran data from SharedPreferences**************");
      return QuranResponse.fromJson(json.decode(cachedData));
    } else {
      // Otherwise, fetch data from API and store it
      try {
        print("**************Fetching Quran data from API**************");
        final response = await http
            .get(Uri.parse('http://api.alquran.cloud/v1/quran/ar.alafasy'));

        if (response.statusCode == 200) {
          // Cache the fetched data in SharedPreferences
          await prefs.setString('quran_data', response.body);
          print(
              "**************Fetched Quran data from API and cached it**************");

          // Return the response data
          return QuranResponse.fromJson(json.decode(response.body));
        } else {
          print(
              "Error: Failed to load Quran data. Status code: ${response.statusCode}");
          throw Exception('Failed to load Quran data');
        }
      } catch (e) {
        print("Error: ${e.toString()}"); // Print the error in case of failure
        throw Exception('Failed to load Quran data');
      }
    }
  }
}
