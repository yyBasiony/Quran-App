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
      child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(color: AppColors.background.withOpacity(0.3), shape: BoxShape.circle),
                child: Icon(Icons.wifi_off_rounded, size: 48.sp, color: AppColors.grey)),
            SizedBox(height: 24.h),
            Text(title ?? 'noInternetTitle'.tr(),
                style: context.textTheme.titleSmall,
                textAlign: TextAlign.center),
            SizedBox(height: 12.h),
            Text(subtitle ?? 'noInternetSubtitle'.tr(),
                style: context.textTheme.titleMedium
                , textAlign: TextAlign.center),
            if (showRetryButton && onRetry != null) ...[
              SizedBox(height: 32.h),
              ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: AppColors.onPrimary,
                    size: 20.sp,
                  ),
                  label: Text('retry'.tr(), style: const TextStyle(color: AppColors.onPrimary, fontWeight: FontWeight.w500)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 2,
                  ))
            ]
          ])),
    );
  }
}
