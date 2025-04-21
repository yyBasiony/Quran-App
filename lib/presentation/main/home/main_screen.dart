import 'package:flutter/material.dart';
import '../../resources/app_constants.dart';
import 'prayer_time_page.dart';
import 'schedule_screen.dart';
import 'setting_screen.dart';
import 'surah_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    PrayerTimesPage(),
    SurahListScreen(),
    ScheduleScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [for (var item in AppConstants.bottomNavBarData) BottomNavigationBarItem(icon: Icon(item.icon), label: item.label)],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF006400),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
