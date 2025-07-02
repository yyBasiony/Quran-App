import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/providers/theme_provider.dart';
import 'package:qanet/providers/locale_provider.dart';
import 'package:qanet/core/themes/app_colors.dart';
import 'package:qanet/l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final local = AppLocalizations.of(context);

    final isDarkMode = themeProvider.isDarkMode;
    final isArabic = localeProvider.locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local.settings,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildSettingTile(
              icon: Icons.nightlight_round,
              title: local.darkMode,
              subtitle: local.toggleDarkMode,
              value: isDarkMode,
              onChanged: (val) => themeProvider.toggleTheme(val),
            ),
            SizedBox(height: 16.h),
            _buildSettingTile(
              icon: Icons.language,
              title: local.language,
              subtitle: isArabic ? local.arabic : local.english,
              value: isArabic,
              onChanged: (_) => localeProvider.toggleLocale(),
            ),
          ],
        ),
      ),
    );
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
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
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
