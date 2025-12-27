import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/extensions/theme_extensions.dart';
import 'package:qanet/data/models/audio_mobel.dart';
import 'package:qanet/providers/surah_details/surah_detail_provider.dart';

class SurahAudioControls extends StatelessWidget {
  final int surahNumber;

  const SurahAudioControls({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SurahDetailProvider>(context);

    return BottomAppBar(
      elevation: 10,
      color: context.theme.cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    provider.isPlaying ? Icons.pause_circle : Icons.play_circle,
                    color: context.primaryColor,
                    size: 30.sp,
                  ),
                  onPressed: provider.isDownloading
                      ? null
                      : (provider.isPlaying
                          ? provider.pauseAudio
                          : () => provider.playFullSurah(surahNumber)),
                ),
                if (provider.isDownloading)
                  Positioned(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(context.primaryColor),
                      ),
                    ),
                  ),
              ],
            ),

                 DropdownButton2<AudioModel>(
                    isExpanded: true,
                    value: provider.selectedReciter,
                    onChanged: provider.isDownloading
                        ? null
                        : (AudioModel? newValue) {
                            if (newValue != null) {
                              provider.changeReciter(newValue);
                            }
                          },
                    items: provider.reciters.map((reciter) {
                      return DropdownMenuItem<AudioModel>(
                        value: reciter,
                        child: Text(
                          reciter.reciterName,
                          style: context.textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: context.theme.cardColor,
                      ),
                    ),
                    buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 45.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: context.primaryColor),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, color: context.primaryColor),
                      iconSize: 24.sp,
                    ),
                    underline: const SizedBox.shrink(),
                  ),
          ],
        ),
      ),
    );
  }
}
