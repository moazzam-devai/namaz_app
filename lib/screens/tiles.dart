import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

class AccordionPage extends StatelessWidget {
  static const headerStyle =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
  static const contentStyle = TextStyle(
      color: Colors.black87, fontSize: 14, fontWeight: FontWeight.normal);

  AccordionPage({super.key});

  // List of Namaz times with Farz, Sunnah, Witr, Time Range, Rewards, and detailed explanations
  final List<Map<String, dynamic>> namazDetails = [
    {
      'title': 'Fajr',
      'titleUrdu': 'فجر',
      'description':
          'Fajr marks the start of the day and holds great significance for spiritual reflection. It is performed before dawn.',
      'farz': '2 Rakahs (Farz)',
      'sunnah': '2 Rakahs before Fajr (Sunnah Mu’akkadah)',
      'witr': 'No Witr prayer for Fajr',
      'timeRange': 'Dawn until sunrise',
      'rewards':
          'Fajr is extremely rewarding. Whoever prays Fajr will be under the protection of Allah throughout the day.',
      'additional':
          'The early hours are ideal for seeking closeness to Allah, especially in the peaceful stillness of the morning.',
      'hadith':
          'The Prophet (ﷺ) said, “Whoever prays Fajr is in the protection of Allah.” (Sahih Muslim)',
      'dua':
          'اللَّهُمَّ اجْعَلْ فِي قَلْبِي نُورًا وَفِي لِسَانِي نُورًا (O Allah, place light in my heart and my tongue.)'
    },
    {
      'title': 'Dhuhr',
      'titleUrdu': 'ظہر',
      'description':
          'Dhuhr is the second prayer performed after midday when the sun starts to decline.',
      'farz': '4 Rakahs (Farz)',
      'sunnah':
          '4 Rakahs before Dhuhr (Sunnah Mu’akkadah), 2 Rakahs after Dhuhr (Sunnah Ghair Mu’akkadah)',
      'witr': 'No Witr prayer for Dhuhr',
      'timeRange':
          'After midday until the shadow of an object is equal to its length',
      'rewards':
          'The reward for Dhuhr is immense. It brings tranquility and peace while drawing you closer to Allah.',
      'additional':
          'Dhuhr serves as a pause to reconnect with Allah during the middle of the day, allowing reflection and gratitude.',
      'hadith':
          'The Prophet (ﷺ) said, "Whoever prays Dhuhr in congregation, his sins will be forgiven."',
      'dua':
          'اللَّهُمَّ اجْعَلْنِي مِنَ الَّذِينَ يُصَلُّونَ فِي جَمَاعَةٍ (O Allah, make me among those who pray in congregation.)'
    },
    {
      'title': 'Asr',
      'titleUrdu': 'عصر',
      'description':
          'Asr is the afternoon prayer, offered before sunset when the shadow of an object equals its length.',
      'farz': '4 Rakahs (Farz)',
      'sunnah': 'No confirmed Sunnah for Asr',
      'witr': 'No Witr prayer for Asr',
      'timeRange': 'When the shadow equals the object’s length until sunset',
      'rewards':
          'The reward for Asr is significant, and praying it on time is especially beneficial for protection from trials.',
      'additional': 'Asr is a reminder to remain mindful of Allah...',
      'hadith':
          'The Prophet (ﷺ) said, "Whoever prays Asr will have their deeds accepted." (Sahih Muslim)',
      'dua':
          'اللَّهُمَّ اجْعَلْ فِي قَلْبِي نُورًا (O Allah, place light in my heart.)'
    },
    {
      'title': 'Maghrib',
      'titleUrdu': 'مغرب',
      'description':
          'Maghrib is offered immediately after sunset and marks the end of the day.',
      'farz': '3 Rakahs (Farz)',
      'sunnah': '2 Rakahs after Maghrib (Sunnah Mu’akkadah)',
      'witr': '1 or 3 Rakahs (Witr, Sunnah Mu’akkadah)',
      'timeRange': 'From sunset until twilight disappears',
      'rewards':
          'Maghrib brings blessings and protection, especially from the hardships of the day.',
      'additional':
          'It’s an opportunity for gratitude and forgiveness as the day concludes.',
      'hadith':
          'The Prophet (ﷺ) said, "Whoever prays Maghrib, his sins will be forgiven." (Sahih al-Jami)',
      'dua':
          'اللَّهُمَّ اغْفِرْ لِي وَرَحْمَتَكَ (O Allah, forgive me and have mercy on me.)'
    },
    {
      'title': 'Isha',
      'titleUrdu': 'عشاء',
      'description':
          'Isha is the final prayer of the day, offered at night after the twilight disappears.',
      'farz': '4 Rakahs (Farz)',
      'sunnah':
          '2 Rakahs before Isha (Sunnah Mu’akkadah), 2 Rakahs after Isha (Sunnah Ghair Mu’akkadah)',
      'witr': '1 or 3 Rakahs (Witr, Sunnah Mu’akkadah)',
      'timeRange': 'From after twilight disappears until midnight',
      'rewards':
          'The reward for Isha is immense. Praying Isha brings peace, tranquility, and protection for the night.',
      'additional':
          'Isha allows you to reflect and unwind before the night’s rest.',
      'hadith':
          'The Prophet (ﷺ) said, "Whoever prays Isha in congregation is as if he spent half the night in prayer."',
      'dua':
          'اللَّهُمَّ اجْعَلْ فِي قَلْبِي نُورًا (O Allah, place light in my heart.)'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222933),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222933),
        title: const Text(
          'Namaz Times',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Accordion(
        headerBorderColor: Colors.blueGrey,
        headerBorderColorOpened: Colors.transparent,
        headerBackgroundColorOpened: Colors.green,
        contentBackgroundColor: Colors.white,
        contentBorderColor: Colors.green,
        contentBorderWidth: 3,
        contentHorizontalPadding: 20,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: namazDetails.map((namaz) {
          return AccordionSection(
            isOpen: true,
            leftIcon: const Icon(Icons.star, color: Colors.green),
            headerBorderRadius: 30,
            headerBackgroundColor: Color(0xFF2F333D),
            headerBackgroundColorOpened: Color(0xFFFFDB6B),
            headerBorderColorOpened: Colors.white,
            headerBorderWidth: 2,
            contentBackgroundColor: Color(0xFFFFDB6B),
            contentBorderColor: Colors.white,
            contentBorderWidth: 2,
            contentBorderRadius: 50,
            contentVerticalPadding: 30,
            header: Row(
              children: [
                Text(
                  '${namaz['title']} (${namaz['titleUrdu']})', // English and Urdu titles
                  style: headerStyle,
                ),
                Spacer(),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: namaz['isOpen'] == true
                      ? Icon(Icons.translate, color: Colors.black)
                      : SizedBox.shrink(),
                ),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaz['description']!,
                    style: contentStyle.copyWith(color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow('Farz', namaz['farz']),
                  _buildInfoRow('Sunnah', namaz['sunnah']),
                  _buildInfoRow('Witr', namaz['witr']),
                  const SizedBox(height: 10),
                  _buildInfoRow('Time Range', namaz['timeRange']),
                  const SizedBox(height: 10),
                  _buildInfoRow('Rewards', namaz['rewards']),
                  const SizedBox(height: 10),
                  Text(
                    'Hadith: ${namaz['hadith']}',
                    style: contentStyle.copyWith(color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dua: ${namaz['dua']}',
                    style: contentStyle.copyWith(color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Additional Explanation: ${namaz['additional']}',
                    style: contentStyle.copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: contentStyle.copyWith(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: contentStyle.copyWith(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

// import 'dart:convert';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shimmer/shimmer.dart';

// class QuranScreen extends StatefulWidget {
//   const QuranScreen({super.key});

//   @override
//   _QuranScreenState createState() => _QuranScreenState();
// }

// class _QuranScreenState extends State<QuranScreen> {
//   List<dynamic> surahs = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchSurahs();
//   }

//   Future<void> fetchSurahs() async {
//     try {
//       final response =
//           await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           surahs = data['data'];
//         });
//       } else {
//         throw Exception('Failed to load surahs');
//       }
//     } catch (e) {
//       print('Error fetching surahs: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF222933),
//       appBar: AppBar(
//         title: Text('Quran Surahs',
//             style: TextStyle(
//               fontFamily: 'Cairo',
//               fontSize: 22,
//               color: Colors.white,
//             )),
//         centerTitle: true,
//         backgroundColor: Color(0xFF222933),
//         elevation: 5,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF222933),
//               Color(0xFF222933),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: surahs.isEmpty
//             ? Center(
//                 child: Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: ListView.builder(
//                     itemCount: 5,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(vertical: 5),
//                         child: Shimmer.fromColors(
//                           baseColor: const Color.fromARGB(56, 255, 255, 255)
//                               .withOpacity(0.1),
//                           highlightColor:
//                               const Color.fromARGB(52, 245, 245, 245),
//                           child: Container(
//                             height: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: surahs.length,
//                 itemBuilder: (context, index) {
//                   final surah = surahs[index];
//                   return Container(
//                     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white.withOpacity(0.2),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 10,
//                           offset: Offset(0, 4),
//                         )
//                       ],
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.3),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             radius: 25,
//                             backgroundColor: Colors.transparent,
//                             backgroundImage:
//                                 AssetImage('assets/images/ayat.png'),
//                           ),
//                           title: Text(
//                             surah['englishName'],
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 color: Color(0xFFFFDB6B),
//                                 fontFamily: 'Cairo'),
//                           ),
//                           subtitle: Text(
//                             'Verses: ${surah['numberOfAyahs']}',
//                             style: TextStyle(
//                                 color: Colors.white, fontFamily: 'Cairo'),
//                           ),
//                           trailing: Icon(
//                             Icons.arrow_forward_ios,
//                             color: Color(0xFFFFDB6B),
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SurahDetailScreen(
//                                   surahNumber: surah['number'],
//                                   surahName: surah['englishName'],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

// class SurahDetailScreen extends StatefulWidget {
//   final int surahNumber;
//   final String surahName;

//   const SurahDetailScreen(
//       {super.key, required this.surahNumber, required this.surahName});

//   @override
//   _SurahDetailScreenState createState() => _SurahDetailScreenState();
// }

// class _SurahDetailScreenState extends State<SurahDetailScreen> {
//   List<dynamic> ayahs = [];
//   final PageController _pageController = PageController();
//   int currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchAyahs();
//   }

//   Future<void> fetchAyahs() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://api.alquran.cloud/v1/surah/${widget.surahNumber}'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           ayahs = data['data']['ayahs'];
//         });
//       } else {
//         throw Exception('Failed to load ayahs');
//       }
//     } catch (e) {
//       print('Error fetching ayahs: $e');
//     }
//   }

//   void _nextPage() {
//     if (currentPage < ayahs.length - 1) {
//       _pageController.nextPage(
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   void _previousPage() {
//     if (currentPage > 0) {
//       _pageController.previousPage(
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.surahName,
//             style: TextStyle(
//               fontFamily: 'Cairo',
//               fontSize: 22,
//               color: Colors.white,
//             )),
//         centerTitle: true,
//         backgroundColor: Color(0xFF222933),
//         elevation: 0,
//         iconTheme: IconThemeData(
//           color: Colors.white, // Set the icon color to white
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF222933),
//               Color(0xFF222933),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: ayahs.isEmpty
//             ? Center(
//                 child: Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: ListView.builder(
//                     itemCount: 5,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(vertical: 5),
//                         child: Shimmer.fromColors(
//                           baseColor: const Color.fromARGB(56, 255, 255, 255)
//                               .withOpacity(0.1),
//                           highlightColor:
//                               const Color.fromARGB(52, 245, 245, 245),
//                           child: Container(
//                             height: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               )
//             : Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Stack(
//                       children: [
//                         // Background Image
//                         Positioned.fill(
//                           child: Image.asset(
//                             'assets/images/bg.jpg',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         // Apply BackdropFilter for blur effect on the background image
//                         Positioned.fill(
//                           child: BackdropFilter(
//                             filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                             child: Container(
//                               color: Colors.black.withOpacity(
//                                   0.3), // Optional: darken the blurred background
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   PageView.builder(
//                     controller: _pageController,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: ayahs.length,
//                     itemBuilder: (context, index) {
//                       final ayah = ayahs[index];
//                       return Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.white.withOpacity(0.15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 10,
//                               offset: Offset(0, 4),
//                             )
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Text(
//                                   ayah['text'],
//                                   style: TextStyle(
//                                       fontSize: 26,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.white,
//                                       fontFamily: 'Cairo',
//                                       height: 1.8), // Adds line height
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               // Added Height Space Between Text and Subtitle
//                               SizedBox(height: 30), // Increased space
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 16.0),
//                                 child: Text(
//                                   'Ayah ${ayah['numberInSurah']}',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Cairo',
//                                       fontSize: 18),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     onPageChanged: (index) {
//                       setState(() {
//                         currentPage = index;
//                       });
//                     },
//                   ),
//                   // Left Arrow
//                   Positioned(
//                     left: 30,
//                     top: MediaQuery.of(context).size.height / 2 - 30,
//                     child: GestureDetector(
//                       onTap: _previousPage,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFFFFDB6B),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         padding: EdgeInsets.all(12),
//                         child: Icon(
//                           Icons.keyboard_arrow_left_rounded,
//                           color: Colors.black,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Right Arrow
//                   Positioned(
//                     right: 30,
//                     top: MediaQuery.of(context).size.height / 2 - 30,
//                     child: GestureDetector(
//                       onTap: _nextPage,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFFFFDB6B),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         padding: EdgeInsets.all(12),
//                         child: Icon(
//                           Icons.keyboard_arrow_right_outlined,
//                           color: Colors.black,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
