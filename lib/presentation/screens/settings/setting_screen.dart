import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/core/themes/app_colors.dart';
import 'package:qanet/l10n/app_localizations.dart';
import 'package:qanet/core/utils/setting_logic.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final isDarkMode = SettingLogic.isDarkMode(context);
    final isArabic = SettingLogic.isArabic(context);

    return Scaffold(
        appBar:
            AppBar(title: Text(local.settings, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.sp)), elevation: 0),
        body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(children: [
              _buildSettingTile(
                icon: Icons.nightlight_round,
                title: local.darkMode,
                subtitle: local.toggleDarkMode,
                value: isDarkMode,
                onChanged: (val) => SettingLogic.toggleTheme(context, val),
              ),
              SizedBox(height: 16.h),
              _buildSettingTile(
                icon: Icons.language,
                title: local.language,
                subtitle: isArabic ? local.arabic : local.english,
                value: isArabic,
                onChanged: (_) => SettingLogic.toggleLocale(context),
              )
            ])));
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.darkAccent),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        leading: Icon(icon, color: Colors.white, size: 26.sp),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp)),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.darkAccent,
        ),
      ),
    );
  }
}
