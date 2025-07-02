import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/core/themes/app_colors.dart';
import 'package:qanet/l10n/app_localizations.dart';

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
    final local = AppLocalizations.of(context);

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
        final localizedCity = _getCityName(local, city);
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            localizedCity,
            style: textTheme.bodyLarge?.copyWith(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 15.sp,
            ),
          ),
        );
      }).toList(),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isDark ? AppColors.darkInputFill : AppColors.white,
        ),
      ),
      buttonStyleData: ButtonStyleData(
        height: 45.h,
        width: 180.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: theme.primaryColor),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(Icons.location_on, color: Colors.white, size: 20.sp),
        iconSize: 24.sp,
      ),
      style: textTheme.bodyLarge?.copyWith(
        color: isDark ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    underline:const  SizedBox.shrink(),
    ),
  ),
);
  }

  String _getCityName(AppLocalizations local, String key) {
    final map = {
      'Cairo': local.cityCairo,
      'Alexandria': local.cityAlexandria,
      'Giza': local.cityGiza,
      'Mansoura': local.cityMansoura,
      'Asyut': local.cityAsyut,
      'Tanta': local.cityTanta,
      'Zagazig': local.cityZagazig,
      'Suez': local.citySuez,
      'Ismailia': local.cityIsmailia,
      'Fayoum': local.cityFayoum,
      'BeniSuef': local.cityBeniSuef,
      'Minya': local.cityMinya,
      'Sohag': local.citySohag,
      'Qena': local.cityQena,
      'Luxor': local.cityLuxor,
      'Aswan': local.cityAswan,
      'Damietta': local.cityDamietta,
      'PortSaid': local.cityPortSaid,
      'SharmElSheikh': local.citySharmElSheikh,
      'Hurghada': local.cityHurghada,
      'Damanhur': local.cityDamanhur,
      'KafrElSheikh': local.cityKafrElSheikh,
      'Mallawi': local.cityMallawi,
      'Banha': local.cityBanha,
      'Arish': local.cityArish,
      'Matruh': local.cityMatruh,
      'Qalyub': local.cityQalyub,
      'Desouk': local.cityDesouk,
      '6October': local.city6October,
      'Obour': local.cityObour,
      'NewCairo': local.cityNewCairo,
      'Helwan': local.cityHelwan,
    };

    return map[key] ?? key;
  }
}
