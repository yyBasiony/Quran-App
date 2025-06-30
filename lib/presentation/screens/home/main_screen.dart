import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/main_provider.dart';
import '../../../providers/prayer_times_provider.dart';
import '../../../providers/surah_provider.dart';
import '../../../providers/search_provider.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../prayer_time/prayer_time_page.dart';
import '../search/search_screen.dart';
import '../settings/setting_screen.dart';
import '../surah/surah_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget _getScreenByIndex(int index) {
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
      body: _getScreenByIndex(provider.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (var item in AppConstants.bottomNavBarData)
            BottomNavigationBarItem(
              icon: Icon(item.icon, size: 24.sp),
              label: item.label,
            )
        ],
        currentIndex: provider.selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
        onTap: provider.setIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 13.sp),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp), 
      ),
    );
  }
}
