import 'package:flutter/material.dart';
import '../../../resources/app_colors.dart'; 

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
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedCity,
              icon: const Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: 20,
              ),
              dropdownColor: AppColors.white,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
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
