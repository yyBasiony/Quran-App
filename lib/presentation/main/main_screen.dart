import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/prayer_times_provider.dart';
import '../../providers/search_provider.dart';
import '../../providers/surah_provider.dart';
import '../prayer_time/prayer_time_page.dart';
import '../resources/app_constants.dart';
import '../search/search_screen.dart';
import '../settings/settings_screen.dart';
import '../surah/surah_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void onTabTapped(int index) => setState(() => selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final labels = ['home'.tr(), 'quran'.tr(), 'search'.tr(), 'settings'.tr()];

    Widget getScreenByIndex(int index) {
      switch (index) {
        case 0:
          return ChangeNotifierProvider(create: (_) => PrayerTimesProvider(), child: const PrayerTimesPage());
        case 1:
          return ChangeNotifierProvider(create: (_) => SurahProvider(), child: const SurahListScreen());
        case 2:
          return ChangeNotifierProvider(create: (_) => SearchProvider(), child: const SearchScreen());
        case 3:
          return const SettingsScreen();
        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      body: getScreenByIndex(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          AppConstants.bottomNavIcons.length,
          (index) => BottomNavigationBarItem(label: labels[index], icon: Icon(AppConstants.bottomNavIcons[index], size: 24.sp)),
        ),
      ),
    );
  }
}
