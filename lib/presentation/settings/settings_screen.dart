import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../extensions/theme_extensions.dart';
import '../../providers/theme_provider.dart';
import '../resources/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final isArabic = context.isArabic, isDarkMode = context.isDarkMode;
    final List<SettingsTileData> settingsTilesData = [
      (value: isDarkMode, title: 'darkMode', subtitle: 'toggleDarkMode', icon: Icons.nightlight_round, onChanged: themeProvider.toggleTheme),
      (
        value: isArabic,
        title: 'language',
        icon: Icons.language,
        subtitle: isArabic ? 'arabic' : 'english',
        onChanged: (_) => context.setLocale(Locale(context.locale.languageCode == 'ar' ? 'en' : 'ar'))
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.sp)), elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(spacing: 16, children: [for (var settingsTileData in settingsTilesData) _buildSettingsTile(settingsTileData)]),
        // child: Column(spacing: 16, children: List.generate(settingsTilesData.length, (i) => _buildSettingsTile(settingsTilesData[i]))),
      ),
    );
  }

  Widget _buildSettingsTile(SettingsTileData settingsTileData) {
    return ListTile(
      tileColor: AppColors.primary,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      leading: Icon(settingsTileData.icon, color: Colors.white, size: 26.sp),
      subtitle: Text(settingsTileData.subtitle.tr(), style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
      trailing: Switch(value: settingsTileData.value, onChanged: settingsTileData.onChanged, activeColor: AppColors.darkAccent),
      title: Text(settingsTileData.title.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp)),
      shape: RoundedRectangleBorder(side: const BorderSide(color: AppColors.darkAccent), borderRadius: BorderRadius.all(Radius.circular(16.r))),
    );
  }
}

typedef SettingsTileData = ({bool value, String title, String subtitle, IconData icon, Function(bool) onChanged});
