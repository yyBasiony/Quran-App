import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../extensions/theme_extensions.dart';
import '../../providers/surah_provider.dart';
import '../resources/app_colors.dart';
import '../widgets/loading_widget.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/status_snackbar.dart';
import 'widgets/surah_card.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => Provider.of<SurahProvider>(context, listen: false).fetchSurahs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('quran'.tr(), style: context.textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: Consumer<SurahProvider>(
        builder: (context, provider, child) {
          if (provider.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              StatusSnackBar.showError(context, provider.errorMessage!.tr());
              provider.clearMessages();
            });
          }

          if (provider.isLoading) {
            return LoadingWidget(message: 'loadingSurahs'.tr());
          }

          if (provider.surahs.isEmpty) {
            return NoInternetWidget(title: 'cannotLoadSurahs'.tr(), onRetry: provider.fetchSurahs, subtitle: 'checkInternetConnection'.tr());
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: TextField(
                  onChanged: provider.filterSurahs,
                  style: context.textTheme.titleSmall,
                  decoration: InputDecoration(
                    hintText: 'searchSurahHint'.tr(),
                    prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 24.sp),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 1.5.w)),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(itemCount: provider.surahs.length, itemBuilder: (_, index) => SurahCard(surah: provider.surahs[index])),
              )
            ],
          );
        },
      ),
    );
  }
}
