import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/extensions/theme_extensions.dart';
import '../../../providers/prayer_times_provider.dart';
import '../../../providers/surah_provider.dart';
import '../../../providers/search_provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_constants.dart';
import '../prayer_time/prayer_time_page.dart';
import '../search/search_screen.dart';
import '../settings/setting_screen.dart';
import '../surah/surah_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    int selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final labels = [
      'home'.tr(),
      'quran'.tr(),
      'search'.tr(),
      'settings'.tr(),
    ];
    Widget getScreenByIndex(int index) {
      switch (index) {
        case 0:
          return ChangeNotifierProvider(
            create: (_) => PrayerTimesProvider(),
            child: const PrayerTimesPage(),
          );
        case 1:
          return ChangeNotifierProvider(
            create: (_) => SurahProvider(),
            child: const SurahListScreen(),
          );
        case 2:
          return ChangeNotifierProvider(
            create: (_) => SearchProvider(),
            child: const SearchScreen(),
          );
        case 3:
          return const SettingScreen();
        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      body: getScreenByIndex(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          AppConstants.bottomNavIcons.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(AppConstants.bottomNavIcons[index], size: 24.sp),
            label: labels[index],
          ),
        ),
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
        onTap:onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 13.sp),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp),
      ),
    );
  }
}
