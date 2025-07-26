import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../extensions/theme_extensions.dart';
import '../../providers/surah_detail_provider.dart';
import '../widgets/loading_widget.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/status_snackbar.dart';
import 'widgets/surah_audio_controls.dart';
import 'widgets/surah_ayah_text.dart';

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  const SurahDetailScreen({super.key, required this.surahName, required this.surahNumber});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late SurahDetailProvider provider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      provider.loadData(widget.surahNumber);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<SurahDetailProvider>(context, listen: false);
  }

  @override
  void dispose() => {provider.disposePlayer(), super.dispose()};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        title: Text(widget.surahName, style: context.textTheme.titleLarge?.copyWith(color: Colors.white)),
      ),
      body: Consumer<SurahDetailProvider>(
        builder: (context, provider, child) {
          if (provider.errorMessage != null) {
            Future.microtask(() {
              StatusSnackBar.showError(context, provider.errorMessage!.tr());
              provider.clearMessages();
            });
          }

          if (provider.isLoading) {
            return LoadingWidget(message: 'loadingSurahContent'.tr());
          }

          if (provider.hasFailedToLoad || (provider.ayahs.isEmpty && provider.reciters.isEmpty)) {
            return NoInternetWidget(
              title: 'cannotLoadSurahContent'.tr(),
              subtitle: 'checkInternetConnection'.tr(),
              onRetry: () => provider.loadData(widget.surahNumber),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: context.primaryColor, width: 1.5.w),
                  ),
                  child: Text(widget.surahName, style: context.textTheme.labelLarge),
                ),
                InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 1.0,
                  maxScale: 3.5,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 900.h),
                    child: SurahAyahText(provider: provider),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<SurahDetailProvider>(
        builder: (context, provider, child) {
          if (provider.hasFailedToLoad || provider.reciters.isEmpty) {
            return const SizedBox.shrink();
          }
          return SurahAudioControls(surahNumber: widget.surahNumber);
        },
      ),
    );
  }
}
