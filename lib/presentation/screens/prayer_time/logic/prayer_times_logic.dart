import 'package:flutter/material.dart';
import 'package:qanet/presentation/resources/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../data/models/prayer_times_model.dart';

class PrayerTimesLogic {
  static Map<String, String> getArabicNames(BuildContext context) {
    return {
      "Fajr": "fajr".tr(),
      "Dhuhr": "dhuhr".tr(),
      "Asr": "asr".tr(),
      "Maghrib": "maghrib".tr(),
      "Isha": "isha".tr(),
    };
  }

  static Map<String, String> getPrayerTimesMap(PrayerTimesModel? times) {
    return {
      "Fajr": times?.fajr ?? "--:--",
      "Dhuhr": times?.dhuhr ?? "--:--",
      "Asr": times?.asr ?? "--:--",
      "Maghrib": times?.maghrib ?? "--:--",
      "Isha": times?.isha ?? "--:--",
    };
  }

  static String getPrayerImage(String key) {
    const images = {
      "Fajr": AppAssets.fajr,
      "Dhuhr": AppAssets.dhuhr,
      "Asr": AppAssets.asr,
      "Maghrib": AppAssets.maghrib,
      "Isha": AppAssets.isha,
    };
    return images[key] ?? AppAssets.isha;
  }

  static String getCityName(BuildContext context, String key) {
    final map = {
      'Cairo': "cityCairo".tr(),
      'Alexandria': "cityAlexandria".tr(),
      'Giza': "cityGiza".tr(),
      'Mansoura': "cityMansoura".tr(),
      'Asyut': "cityAsyut".tr(),
      'Tanta': "cityTanta".tr(),
      'Zagazig': "cityZagazig".tr(),
      'Suez': "citySuez".tr(),
      'Ismailia': "cityIsmailia".tr(),
      'Fayoum': "cityFayoum".tr(),
      'BeniSuef': "cityBeniSuef".tr(),
      'Minya': "cityMinya".tr(),
      'Sohag': "citySohag".tr(),
      'Qena': "cityQena".tr(),
      'Luxor': "cityLuxor".tr(),
      'Aswan': "cityAswan".tr(),
      'Damietta': "cityDamietta".tr(),
      'PortSaid': "cityPortSaid".tr(),
      'SharmElSheikh': "citySharmElSheikh".tr(),
      'Hurghada': "cityHurghada".tr(),
      'Damanhur': "cityDamanhur".tr(),
      'KafrElSheikh': "cityKafrElSheikh".tr(),
      'Mallawi': "cityMallawi".tr(),
      'Banha': "cityBanha".tr(),
      'Arish': "cityArish".tr(),
      'Matruh': "cityMatruh".tr(),
      'Qalyub': "cityQalyub".tr(),
      'Desouk': "cityDesouk".tr(),
      '6October': "city6October".tr(),
      'Obour': "cityObour".tr(),
      'NewCairo': "cityNewCairo".tr(),
      'Helwan': "cityHelwan".tr(),
    };

    return map[key] ?? key;
  }
}
