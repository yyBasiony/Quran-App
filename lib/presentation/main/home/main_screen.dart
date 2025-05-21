import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/main_provider.dart';
import '../../../providers/prayer_times_provider.dart';
import '../../../providers/surah_provider.dart';
import '../../../providers/search_provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_constants.dart';
import 'prayer_time_page.dart';
import 'search_screen.dart';
import 'setting_screen.dart';
import 'surah_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Widget> _screens = [
      ChangeNotifierProvider(
        create: (_) => PrayerTimesProvider(),
        child: const PrayerTimesPage(),
      ),
      ChangeNotifierProvider(
        create: (_) => SurahProvider(),
        child: const SurahListScreen(),
      ),
      ChangeNotifierProvider(
        create: (_) => SearchProvider(),
        child: const SearchScreen(),
      ),
      const SettingScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: provider.selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (var item in AppConstants.bottomNavBarData)
            BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            )
        ],
        currentIndex: provider.selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
        onTap: provider.setIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
