import 'package:al_khair/controllers/HadeesController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HadithController controller = Get.put(HadithController());

    return Scaffold(
      backgroundColor: Color(0xFF222933),
      appBar: AppBar(
        title: Text(
          'Hadiths',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF222933),
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.hadithResponse.value == null) {
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
                        highlightColor: const Color.fromARGB(52, 245, 245, 245),
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
          } else {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount:
                        controller.hadithResponse.value!.hadiths.data.length,
                    itemBuilder: (context, index) {
                      final hadith =
                          controller.hadithResponse.value!.hadiths.data[index];
                      return Card(
                        color: Color(0xFF2F333D),
                        margin: EdgeInsets.symmetric(vertical: 12),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.black.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Hadith #${hadith.hadithNumber}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Color(0xFFFFDB6B),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      String textToCopy =
                                          controller.isEnglish.value
                                              ? hadith.hadithEnglish
                                              : hadith.hadithUrdu;
                                      Clipboard.setData(
                                          ClipboardData(text: textToCopy));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Text copied to clipboard'),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                hadith.englishNarrator,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 16),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.isEnglish.value
                                            ? hadith.hadithEnglish
                                            : hadith.hadithUrdu,
                                        key: ValueKey<bool>(
                                            controller.isEnglish.value),
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    controller.isEnglish.value
                                        ? 'English'
                                        : 'Urdu',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Obx(() {
                                    return Switch(
                                      value: controller.isEnglish.value,
                                      onChanged: (value) {
                                        print("Switch changed: $value");
                                        controller.toggleLanguage();
                                      },
                                      activeColor: Color(0xFFFFDB6B),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Obx(
                  () {
                    return AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      bottom: controller.showFab.value ? 50 : -100,
                      right: 20,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: controller.showFab.value ? 1 : 0,
                        child: FloatingActionButton(
                          backgroundColor: Color(0xFFFFDB6B),
                          onPressed: () {
                            controller.scrollToTop();
                          },
                          child: Icon(Icons.arrow_upward, color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
