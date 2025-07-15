import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/data/models/audio_mobel.dart';
import 'package:qanet/providers/surah_detail_provider.dart';

class SurahAudioControls extends StatelessWidget {
  final int surahNumber;

  const SurahAudioControls({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SurahDetailProvider>(context);
    final theme = Theme.of(context);

    return BottomAppBar(
        elevation: 10,
        color: theme.cardColor,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              IconButton(
                  icon: Icon(provider.isPlaying ? Icons.pause_circle : Icons.play_circle, color: theme.primaryColor, size: 30.sp),
                  onPressed: provider.isPlaying ? provider.pauseAudio : () => provider.playFullSurah(surahNumber)),
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
                      child: Text(reciter.reciterName,   style: theme.textTheme.headlineSmall, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  dropdownStyleData: DropdownStyleData(
                      maxHeight: 200.h, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: theme.cardColor)),
                  buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 45.h,
                      width: 180.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: theme.primaryColor))),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: theme.primaryColor),
                    iconSize: 24.sp,
                  ),
                  underline: const SizedBox.shrink())
            ])));
  }
}
