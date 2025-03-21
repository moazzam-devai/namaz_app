// import 'package:al_khair/screens/Hadees/hadees_screen.dart';
// import 'package:al_khair/screens/HomeScreen/home_screen.dart';
// import 'package:al_khair/screens/QuranPak/Quran_screen.dart';
// import 'package:flutter/material.dart';

// class BottomNavBarWithFAB extends StatefulWidget {
//   const BottomNavBarWithFAB({super.key});

//   @override
//   _BottomNavBarWithFABState createState() => _BottomNavBarWithFABState();
// }

// class _BottomNavBarWithFABState extends State<BottomNavBarWithFAB> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     HomeScreen(),
//     QuranScreen(),
//     HadithScreen(),
//     ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF222933),
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomAppBar(
//         color: const Color(0xFF2F333D),
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 30.0,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.home,
//                   size: 28,
//                   color: _currentIndex == 0 ? Colors.white : Colors.white70,
//                 ),
//                 onPressed: () => _onItemTapped(0),
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.search,
//                   size: 28,
//                   color: _currentIndex == 1 ? Colors.white : Colors.white70,
//                 ),
//                 onPressed: () => _onItemTapped(1),
//               ),
//               const SizedBox(width: 48), // Space for FAB
//               IconButton(
//                 icon: Icon(
//                   Icons.notifications,
//                   size: 28,
//                   color: _currentIndex == 2 ? Colors.white : Colors.white70,
//                 ),
//                 onPressed: () => _onItemTapped(2),
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.account_circle,
//                   size: 28,
//                   color: _currentIndex == 3 ? Colors.white : Colors.white70,
//                 ),
//                 onPressed: () => _onItemTapped(3),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Action to be performed when FAB is pressed
//           print('Floating action button pressed');
//         },
//         backgroundColor: const Color(0xFFFFDB6B),
//         elevation: 12,
//         child: Icon(
//           Icons.alarm,
//           size: 35,
//           color: Colors.black,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Profile Screen',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }
import 'package:al_khair/screens/Alarm/Add_Alarm.dart';
import 'package:al_khair/screens/Hadees/hadees_screen.dart';
import 'package:al_khair/screens/HomeScreen/home_screen.dart';
import 'package:al_khair/screens/QuranPak/Quran_screen.dart';
import 'package:al_khair/screens/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarWithFAB extends StatefulWidget {
  const BottomNavBarWithFAB({super.key});

  @override
  _BottomNavBarWithFABState createState() => _BottomNavBarWithFABState();
}

class _BottomNavBarWithFABState extends State<BottomNavBarWithFAB>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;

  final List<Widget> _screens = [
    HomeScreen(),
    QuranScreen(),
    HadithScreen(),
    AccordionPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.forward(from: 0); // Restart animation on every tap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222933),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF2F333D),
        shape: const CircularNotchedRectangle(),
        notchMargin: 20.0,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem('assets/icons/home.svg', "Home", 0),
              _buildNavItem('assets/icons/quran.svg', "Quran", 1),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem('assets/icons/had.svg', "Hadees", 2),
              _buildNavItem('assets/icons/profil.svg', "Profile", 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAlarm()),
          );
        },
        backgroundColor: const Color(0xFFFFDB6B),
        elevation: 8,
        child: const Icon(
          Icons.alarm,
          size: 28,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(String svgPath, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            width: 28,
            height: 28,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF2F333D) : Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
