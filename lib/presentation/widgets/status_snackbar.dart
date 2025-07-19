import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qanet/presentation/resources/app_colors.dart';

class StatusSnackBar {
  static void showNoInternet(BuildContext context, {String? customMessage}) {
    _showSnackBar(
      context,
      message: customMessage ?? 'noInternetMessage'.tr(),
      backgroundColor: AppColors.prayerCard3,
      icon: Icons.wifi_off_rounded,
      duration: const Duration(seconds: 4),
      showAction: true,
    );
  }

  static void showCacheData(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.orange,
      icon: Icons.offline_bolt_rounded,
      duration: const Duration(seconds: 3),
    );
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.prayerCard3,
      icon: Icons.error_outline_rounded,
      duration: const Duration(seconds: 3),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.prayerCard4,
      icon: Icons.check_circle_outline_rounded,
      duration: const Duration(seconds: 2),
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.prayerCard2,
      icon: Icons.info_outline_rounded,
      duration: const Duration(seconds: 3),
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
    bool showAction = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white)))
      ]),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      elevation: 6,
      action: showAction
          ? SnackBarAction(
              label: 'ok'.tr(),
              textColor: AppColors.white,
              backgroundColor: AppColors.white.withOpacity(0.2),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            )
          : null,
    ));
  }
}
