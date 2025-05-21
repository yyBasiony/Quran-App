import 'package:flutter/material.dart';
import 'package:quran_app/presentation/resources/app_colors.dart';

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

    final dropdownColor = isDark ? AppColors.darkInputFill : AppColors.white;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedCity,
              icon: Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: 20,
              ),
              dropdownColor: dropdownColor,
              style: textTheme.bodyLarge?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
              underline: Container(height: 0),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onCityChanged(newValue);
                }
              },
              items: cities.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(
                    city,
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
