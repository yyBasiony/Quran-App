import 'package:flutter/material.dart';

import '../presentation/start_screen.dart';

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  StartScreen(),
    );
  }
}
