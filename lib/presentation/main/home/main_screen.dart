import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/main_provider.dart';
import '../../resources/app_constants.dart';
import '../../resources/app_colors.dart';
import 'prayer_time_page.dart';
import 'search_screen.dart';
import 'setting_screen.dart';
import 'surah_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    PrayerTimesPage(),
    SurahListScreen(),
    SearchScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);

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
        onTap: provider.setIndex,
      ),
    );
  }
}
