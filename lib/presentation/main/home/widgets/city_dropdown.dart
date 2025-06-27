import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/presentation/resources/app_colors.dart';
import 'package:qanet/presentation/resources/app_constants.dart';

class CityDropdown extends StatelessWidget {
  final String selectedCity;
  final List<String> cities;
  final Function(String) onCityChanged;

  const CityDropdown({
    super.key,
    required this.selectedCity,
    required this.cities,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: DropdownButton<String>(
              value: selectedCity,
              icon: Icon(
                Icons.location_on,
                color: isDark ? Colors.white : Colors.black,
                size: 20.sp,
              ),
              dropdownColor: isDark ? AppColors.darkInputFill : AppColors.white,
              style: textTheme.bodyLarge?.copyWith(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) onCityChanged(newValue);
              },
              items: cities.map((city) {
                final arabicName = AppConstants.cityNamesArabic[city] ?? city;
                return DropdownMenuItem<String>(
                    value: city,
                    child: Text(arabicName,
                        style: textTheme.bodyLarge?.copyWith(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15.sp,
                        )));
              }).toList(),
            )));
  }
}
