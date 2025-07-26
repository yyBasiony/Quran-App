import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions/theme_extensions.dart';
import '../../resources/app_colors.dart';
import '../logic/prayer_times_logic.dart';

class CityDropdown extends StatelessWidget {
  final String selectedCity;
  final List<String> cities;
  final Function(String) onCityChanged;

  const CityDropdown({
    super.key,
    required this.cities,
    required this.selectedCity,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textTheme = context.textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: DropdownButton2<String>(
          isExpanded: true,
          value: selectedCity,
          onChanged: (String? newValue) {
            if (newValue != null) onCityChanged(newValue);
          },
          items: cities.map((city) {
            final localizedCity = PrayerTimesLogic.getCityName(context, city);
            return DropdownMenuItem<String>(value: city, child: Text(localizedCity, style: textTheme.headlineSmall));
          }).toList(),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: isDark ? AppColors.darkInputFill : AppColors.white),
          ),
          buttonStyleData: ButtonStyleData(
            height: 45.h,
            width: 180.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: context.primaryColor)),
          ),
          iconStyleData: IconStyleData(icon: Icon(Icons.location_on, color: Colors.white, size: 20.sp), iconSize: 24.sp),
          style: textTheme.bodyLarge,
          underline: const SizedBox.shrink(),
        ),
      ),
    );
  }
}
