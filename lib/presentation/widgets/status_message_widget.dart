import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/presentation/resources/app_colors.dart';

class StatusMessageWidget extends StatelessWidget {
  final String? message;
  final bool isFromCache;
  final bool isError;
  final bool isSuccess;
  final VoidCallback? onRetry;

  const StatusMessageWidget({
    super.key,
    this.message,
    this.isFromCache = false,
    this.isError = false,
    this.isSuccess = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();

    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    Color textColor;
    IconData icon;

    if (isError) {
      backgroundColor = AppColors.prayerCard3.withOpacity(0.1);
      borderColor = AppColors.prayerCard3;
      iconColor = AppColors.prayerCard3;
      textColor = AppColors.prayerCard3.withOpacity(0.8);
      icon = Icons.error_outline_rounded;
    } else if (isSuccess) {
      backgroundColor = AppColors.prayerCard4.withOpacity(0.1);
      borderColor = AppColors.prayerCard4;
      iconColor = AppColors.prayerCard4;
      textColor = AppColors.prayerCard4.withOpacity(0.8);
      icon = Icons.check_circle_outline_rounded;
    } else if (isFromCache) {
      backgroundColor = AppColors.orange.withOpacity(0.1);
      borderColor = AppColors.orange;
      iconColor = AppColors.orange;
      textColor = AppColors.orange.withOpacity(0.8);
      icon = Icons.offline_bolt_rounded;
    } else {
      backgroundColor = AppColors.prayerCard2.withOpacity(0.1);
      borderColor = AppColors.prayerCard2;
      iconColor = AppColors.prayerCard2;
      textColor = AppColors.prayerCard2.withOpacity(0.8);
      icon = Icons.info_outline_rounded;
    }

    return Container(
        margin: EdgeInsets.all(12.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [BoxShadow(color: borderColor.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))]),
        child: Row(children: [
          Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18.sp)),
          SizedBox(width: 12.w),
          Expanded(child: Text(message!, style: TextStyle(color: textColor, fontSize: 13.sp, fontWeight: FontWeight.w500))),
          if (onRetry != null) ...[
            SizedBox(width: 12.w),
            GestureDetector(
                onTap: onRetry,
                child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.refresh_rounded,
                      color: iconColor,
                      size: 16.sp,
                    )))
          ]
        ]));
  }
}
