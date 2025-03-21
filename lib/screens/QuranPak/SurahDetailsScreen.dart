import 'package:al_khair/Model/quran_model.dart';
import 'package:al_khair/controllers/Quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:google_fonts/google_fonts.dart';

class SurahDetailsScreen extends StatelessWidget {
  final Surah surah;

  const SurahDetailsScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pause the audio before navigating back
        Get.find<SurahController>().pauseAudio();
        return true; // Allow the pop to occur
      },
      child: Scaffold(
        backgroundColor: Color(0xFF222933),
        appBar: AppBar(
          backgroundColor: Color(0xFF222933),
          title: Text(
            surah.englishName,
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: GetBuilder<SurahController>(
                builder: (controller) => Icon(
                  controller.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Get.find<SurahController>().playAyahs(surah);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Surah Name
                Text(
                  surah.name,
                  style: GoogleFonts.poppins(
                      color: Color(0xFFFFDB6B),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),

                // English Name
                Text(
                  surah.englishName,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),

                // English Translation of Surah Name
                Text(
                  surah.englishNameTranslation,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 16),

                // List of Ayahs
                Text(
                  'Ayahs:',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: surah.ayahs.map((ayah) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.0), // Space between Ayahs
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Ayah ${ayah.number}:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0xFFFFDB6B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 8), // Space between Ayah number and text
                          Text(
                            ayah.text,
                            style: GoogleFonts.amiri(
                              fontSize: 20,
                              height: 2.8,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
