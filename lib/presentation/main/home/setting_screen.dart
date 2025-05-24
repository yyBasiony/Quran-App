import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/providers/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: const Icon(Icons.nightlight_round, color: Colors.white),
            title: const Text(
              'الوضع الداكن',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: const Text(
              'تبديل الوضع الليلي',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
              activeColor: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
