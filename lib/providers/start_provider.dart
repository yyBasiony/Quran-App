import 'package:flutter/material.dart';

class StartProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startApp(BuildContext context, VoidCallback onStart) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      _isLoading = false;
      notifyListeners();
      onStart(); 
    });
  }
}

