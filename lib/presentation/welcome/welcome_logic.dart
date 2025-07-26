import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartLogic {
  static Future<void> handleStartButton(BuildContext context, VoidCallback onStart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);

    onStart();
  }
}
