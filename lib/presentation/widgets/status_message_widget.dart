import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusMessageWidget extends StatelessWidget {
  final String? message;
  final bool isFromCache;
  final VoidCallback? onRetry;

  const StatusMessageWidget({
    super.key,
    this.message,
    this.isFromCache = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isFromCache ? Colors.orange.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
        border: Border.all(
          color: isFromCache ? Colors.orange : Colors.blue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            isFromCache ? Icons.offline_bolt : Icons.info,
            color: isFromCache ? Colors.orange : Colors.blue,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message!,
              style: TextStyle(
                color: isFromCache ? Colors.orange[800] : Colors.blue[800],
                fontSize: 12.sp,
              ),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onRetry,
              child: Icon(
                Icons.refresh,
                color: isFromCache ? Colors.orange : Colors.blue,
                size: 18.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
