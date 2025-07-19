import 'package:flutter/material.dart';
import 'package:qanet/extensions/theme_extensions.dart';
import 'package:qanet/presentation/resources/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: color ?? AppColors.primary,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: context.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
