import 'package:flutter/material.dart';

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
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedCity,
              icon: const Icon(Icons.location_on, color: Color(0xFF006400), size: 20),
              dropdownColor: Colors.white,
              style: const TextStyle(
                color: Color(0xff3e6d69),
                fontSize: 16,
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
                  child: Text(city, style: const TextStyle(color: Color(0xFF006400))),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
