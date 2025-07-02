import 'package:qanet/core/themes/app_assets.dart';
import 'package:qanet/l10n/app_localizations.dart';
import '../../../data/models/prayer_times_model.dart';

class PrayerTimesLogic {
  static Map<String, String> getArabicNames(AppLocalizations local) {
    return {
      "Fajr": local.fajr,
      "Dhuhr": local.dhuhr,
      "Asr": local.asr,
      "Maghrib": local.maghrib,
      "Isha": local.isha,
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
      "Fajr": AppAssets.Fajr,
      "Dhuhr": AppAssets.Dhuhr,
      "Asr": AppAssets.Asr,
      "Maghrib": AppAssets.Maghrib,
      "Isha": AppAssets.Isha,
    };
    return images[key] ?? AppAssets.Isha;
  }
   static String getCityName(AppLocalizations local, String key) {
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
