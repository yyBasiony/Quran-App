import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/presentation/resources/app_assets.dart';
import 'package:quran_app/presentation/resources/app_colors.dart';
import 'package:quran_app/presentation/resources/app_routes.dart';
import '../../providers/start_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(AppAssets.welcome, fit: BoxFit.cover, colorBlendMode: BlendMode.darken),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 90),
                  Text(
                    "يوفر لك هذا التطبيق مواقيت الصلاة، آيات قرآنية ",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 22, color: AppColors.orange, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  Consumer<StartProvider>(
                    builder: (context, startProvider, _) {
                      return ElevatedButton(
                          onPressed: startProvider.isLoading
                              ? null
                              : () async {
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setBool('is_first_time', false);

                                  startProvider.startApp(
                                    context,
                                    () => Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.mainScreen,
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: startProvider.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("لنبدأ",
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
