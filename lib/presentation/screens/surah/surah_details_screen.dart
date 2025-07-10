import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/presentation/screens/surah/widgets/surah_ayah_text.dart';
import 'package:qanet/presentation/screens/surah/widgets/surah_audio_controls.dart';
import 'package:qanet/providers/surah_detail_provider.dart';
class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const SurahDetailScreen({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late SurahDetailProvider provider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      provider.setContext(context);
      provider.loadData(widget.surahNumber);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<SurahDetailProvider>(context, listen: false);
  }

  @override
  void dispose() {
    provider.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: theme.primaryColor, title: Text(widget.surahName, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white))),
      body: Consumer<SurahDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 16.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor, width: 1.5.w),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(widget.surahName,
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: theme.primaryColor, fontFamily: 'Uthmani'))),
                InteractiveViewer(
                    panEnabled: true,
                    scaleEnabled: true,
                    minScale: 1.0,
                    maxScale: 3.5,
                    child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: 900.h,
                        ),
                        child: SurahAyahText(provider: provider))),
                SizedBox(height: 40.h),
              ]
              )
              );
        },
      ),
      bottomNavigationBar: SurahAudioControls(surahNumber: widget.surahNumber),
    );
  }
}
