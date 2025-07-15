import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/core/utils/prayer_times_logic.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../resources/app_constants.dart';
import '../../resources/app_colors.dart';
import '../../../providers/prayer_times_provider.dart';
import 'widgets/city_dropdown.dart';
import 'widgets/prayer_card.dart';

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrayerTimesProvider>(context);
    final prayerTimes = provider.prayerTimes;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    final arabicNames = PrayerTimesLogic.getArabicNames(context);
    final prayers = PrayerTimesLogic.getPrayerTimesMap(prayerTimes)..remove(provider.nextPrayer);

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
            backgroundColor: theme.primaryColor,
            centerTitle: true,
            title: CityDropdown(selectedCity: provider.selectedCity, cities: AppConstants.cities, onCityChanged: provider.changeCity)),
        body: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(children: [
              SizedBox(height: 10.h),
              Container(
                  height: 220.h,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(fit: StackFit.expand, children: [
                    Transform.scale(
                        scale: 1.1,
                        child: Image.asset(PrayerTimesLogic.getPrayerImage(provider.nextPrayer),
                            fit: BoxFit.fitHeight, alignment: Alignment.bottomCenter)),
                    Container(color: Colors.black.withOpacity(0.1)),
                    Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        arabicNames[provider.nextPrayer] ?? provider.nextPrayer,
                        style: textTheme.titleLarge,
                      ),
                      SizedBox(height: 8.h),
                      Text(provider.nextPrayerTime, style: textTheme.titleLarge)
                    ]))
                  ])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Text('prayerTimes'.tr(),
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                        fontSize: 20.sp,
                      ))),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                children: prayers.entries.map((entry) {
                  final englishKey = entry.key;
                  final arabicName = arabicNames[englishKey] ?? englishKey;

                  return PrayerCard(
                    name: arabicName,
                    time: entry.value,
                    imageKey: englishKey,
                  );
                }).toList(),
              ))
            ])));
  }
}
