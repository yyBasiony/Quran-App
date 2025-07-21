import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/extensions/theme_extensions.dart';
import 'package:qanet/presentation/screens/surah/widgets/surah_card.dart';
import 'package:qanet/presentation/widgets/loading_widget.dart';
import 'package:qanet/presentation/widgets/no_internet_widget.dart';
import 'package:qanet/presentation/resources/app_colors.dart';
import 'package:qanet/presentation/widgets/status_snackbar.dart';
import 'package:qanet/providers/surah_provider.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<SurahProvider>(context, listen: false).fetchSurahs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'quran'.tr(),
          style: context.textTheme.titleLarge?.copyWith(color: AppColors.white),
        ),
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
            return NoInternetWidget(
              title: 'cannotLoadSurahs'.tr(),
              subtitle: 'checkInternetConnection'.tr(),
              onRetry: provider.fetchSurahs,
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: TextField(
                  style: context.textTheme.titleSmall,
                  decoration: InputDecoration(
                    hintText: 'searchSurahHint'.tr(),
                    prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 24.sp),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
                    ),
                  ),
                  onChanged: provider.filterSurahs,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.surahs.length,
                  itemBuilder: (context, index) {
                    final surah = provider.surahs[index];
                    return SurahCard(surah: surah);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
