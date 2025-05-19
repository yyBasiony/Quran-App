import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/presentation/resources/app_colors.dart';
import 'main/home/main_screen.dart';
import '../../providers/start_provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final startProvider = Provider.of<StartProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/startscreen.png',
              height: 340,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 200,
            child: Column(
              children: [
                const Spacer(),
                Container(
                  height: 380,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 12),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 60),
                      Text(
                        "تطبيق اسلامي",
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "هذا تطبيق إسلامي يقدم آيات قرآنية ومواقيت الصلاة...",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: startProvider.isLoading
                            ? null
                            : () {
                                startProvider.startApp(
                                  context,
                                  () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const MainScreen(),
                                    ),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: startProvider.isLoading
                            ? const CircularProgressIndicator(color: AppColors.white)
                            : Text(
                                "لنبدأ  ",
                                style: textTheme.bodyLarge?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
