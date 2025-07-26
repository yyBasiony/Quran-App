import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../extensions/theme_extensions.dart';
import '../../providers/prayer_times_provider.dart';
import '../resources/app_colors.dart';
import '../resources/app_constants.dart';
import 'logic/prayer_times_logic.dart';
import 'widgets/city_dropdown.dart';
import 'widgets/prayer_card.dart';

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrayerTimesProvider>(context);
    final prayerTimes = provider.prayerTimes;

    final arabicNames = PrayerTimesLogic.getArabicNames(context);
    final prayers = PrayerTimesLogic.getPrayerTimesMap(prayerTimes)..remove(provider.nextPrayer);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.primaryColor,
        title: CityDropdown(selectedCity: provider.selectedCity, cities: AppConstants.cities, onCityChanged: provider.changeCity),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              height: 220.h,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Transform.scale(
                    scale: 1.1,
                    child:
                        Image.asset(PrayerTimesLogic.getPrayerImage(provider.nextPrayer), fit: BoxFit.fitHeight, alignment: Alignment.bottomCenter),
                  ),
                  Container(color: Colors.black.withOpacity(0.1)),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(arabicNames[provider.nextPrayer] ?? provider.nextPrayer, style: context.textTheme.titleLarge),
                        SizedBox(height: 8.h),
                        Text(provider.nextPrayerTime, style: context.textTheme.titleLarge)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                'prayerTimes'.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: context.isDarkMode ? AppColors.darkTextPrimary : AppColors.textPrimary, fontSize: 20.sp),
              ),
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              children: prayers.entries.map((entry) {
                final englishKey = entry.key;
                final arabicName = arabicNames[englishKey] ?? englishKey;

                return PrayerCard(name: arabicName, time: entry.value, imageKey: englishKey);
              }).toList(),
            ))
          ],
        ),
      ),
    );
  }
}
