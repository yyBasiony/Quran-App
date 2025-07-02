import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/l10n/app_localizations.dart';
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
    final local = AppLocalizations.of(context);

    final labels = [
      local.home,
      local.quran,
      local.search,
      local.settings,
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
      body: getScreenByIndex(provider.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          AppConstants.bottomNavIcons.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(AppConstants.bottomNavIcons[index], size: 24.sp),
            label: labels[index],
          ),
        ),
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
