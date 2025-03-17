import 'package:flutter/material.dart';

import 'main/home/prayer_time_page.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffa3ebe3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Image.asset(
                'assets/images.png',
                width: 240,
                height: 240,
                fit: BoxFit.cover,
              )),
          const SizedBox(height: 40),
          Container(
            height: 380,
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
              )
            ]),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text("Islamic App",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
                const SizedBox(height: 12),
                const Text("Ini adalah Aplikasi Dzikir Pagi Dan Petang. Aplikasi ini cocok untuk kalian yang mau menghafal dzikir pagi petang.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>const PrayerTimesScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffa3ebe3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                    child: const Text("Let's get started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ))),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
