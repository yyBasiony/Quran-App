import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/data/models/audio_mobel.dart';
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
            return Column(children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.primaryColor, width: 1.5.w),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(widget.surahName,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                        fontFamily: 'Uthmani',
                      ))),
              Expanded(
                  child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: RichText(
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontFamily: 'Uthmani',
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                            children: provider.ayahs.map((ayah) {
                              return TextSpan(text: '${ayah.text} ﴿${ayah.number}﴾ ');
                            }).toList(),
                          ))))
            ]);
          },
        ),
        bottomNavigationBar: Consumer<SurahDetailProvider>(builder: (context, provider, child) {
          return BottomAppBar(
              elevation: 10,
              color: theme.cardColor,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    IconButton(
                      icon: Icon(
                        provider.isPlaying ? Icons.pause_circle : Icons.play_circle,
                        color: theme.primaryColor,
                        size: 30.sp,
                      ),
                      onPressed: provider.isPlaying ? provider.pauseAudio : () => provider.playFullSurah(widget.surahNumber),
                    ),
DropdownButton2<AudioModel>(
  isExpanded: true,
  value: provider.selectedReciter,
  onChanged: (AudioModel? newValue) {
    if (newValue != null) {
      provider.changeReciter(newValue);
    }
  },
  items: provider.reciters.map((reciter) {
    return DropdownMenuItem<AudioModel>(
      value: reciter,
      child: Text(
        reciter.reciterName,
        style: TextStyle(fontSize: 14.sp),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }).toList(),
  dropdownStyleData: DropdownStyleData(
    maxHeight: 200.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: theme.cardColor,
    ),
  ),
  buttonStyleData: ButtonStyleData(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    height: 45.h,
    width: 180.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: theme.primaryColor),
    ),
  ),
  iconStyleData: IconStyleData(
    icon: Icon(Icons.arrow_drop_down, color: theme.primaryColor),
    iconSize: 24.sp,
  ),
    underline:const  SizedBox.shrink(),

)
                  ])));
        }));
  }
}
