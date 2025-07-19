import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'package:qanet/presentation/widgets/status_snackbar.dart';

class ConnectivityHelper {
  static Future<bool> hasInternet() async {
    try {
      final connectivityResults = await Connectivity().checkConnectivity();
      
      final hasActiveConnection = connectivityResults.any((result) => 
        result == ConnectivityResult.mobile || 
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet
      );
      
      if (!hasActiveConnection) {
        return false;
      }
      
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
  
  static void showNoInternetSnackBar(BuildContext context, {String? customMessage}) {
    StatusSnackBar.showNoInternet(context, customMessage: customMessage);
  }
  
  static void showCacheDataSnackBar(BuildContext context, String message) {
    StatusSnackBar.showCacheData(context, message);
  }
}
