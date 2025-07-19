import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qanet/extensions/theme_extensions.dart';
import 'package:qanet/presentation/resources/app_colors.dart';

class NoInternetWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  const NoInternetWidget({
    super.key,
    this.title,
    this.subtitle,
    this.onRetry,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 64.sp,
            color: Colors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            title ?? 'noInternetTitle'.tr(),
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle ?? 'noInternetSubtitle'.tr(),
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          if (showRetryButton && onRetry != null) ...[
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                'retry'.tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
