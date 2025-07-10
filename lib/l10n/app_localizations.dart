import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @quran.
  ///
  /// In ar, this message translates to:
  /// **'الْـقُــرْآنُ'**
  String get quran;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @prayerTimes.
  ///
  /// In ar, this message translates to:
  /// **'مواقيت الصلاة'**
  String get prayerTimes;

  /// No description provided for @fajr.
  ///
  /// In ar, this message translates to:
  /// **'الفجر'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In ar, this message translates to:
  /// **'الظهر'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In ar, this message translates to:
  /// **'العصر'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In ar, this message translates to:
  /// **'المغرب'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In ar, this message translates to:
  /// **'العشاء'**
  String get isha;

  /// No description provided for @cityCairo.
  ///
  /// In ar, this message translates to:
  /// **'القاهرة'**
  String get cityCairo;

  /// No description provided for @cityAlexandria.
  ///
  /// In ar, this message translates to:
  /// **'الإسكندرية'**
  String get cityAlexandria;

  /// No description provided for @cityGiza.
  ///
  /// In ar, this message translates to:
  /// **'الجيزة'**
  String get cityGiza;

  /// No description provided for @cityMansoura.
  ///
  /// In ar, this message translates to:
  /// **'المنصورة'**
  String get cityMansoura;

  /// No description provided for @cityAsyut.
  ///
  /// In ar, this message translates to:
  /// **'أسيوط'**
  String get cityAsyut;

  /// No description provided for @cityTanta.
  ///
  /// In ar, this message translates to:
  /// **'طنطا'**
  String get cityTanta;

  /// No description provided for @cityZagazig.
  ///
  /// In ar, this message translates to:
  /// **'الزقازيق'**
  String get cityZagazig;

  /// No description provided for @citySuez.
  ///
  /// In ar, this message translates to:
  /// **'السويس'**
  String get citySuez;

  /// No description provided for @cityIsmailia.
  ///
  /// In ar, this message translates to:
  /// **'الإسماعيلية'**
  String get cityIsmailia;

  /// No description provided for @cityFayoum.
  ///
  /// In ar, this message translates to:
  /// **'الفيوم'**
  String get cityFayoum;

  /// No description provided for @cityBeniSuef.
  ///
  /// In ar, this message translates to:
  /// **'بني سويف'**
  String get cityBeniSuef;

  /// No description provided for @cityMinya.
  ///
  /// In ar, this message translates to:
  /// **'المنيا'**
  String get cityMinya;

  /// No description provided for @citySohag.
  ///
  /// In ar, this message translates to:
  /// **'سوهاج'**
  String get citySohag;

  /// No description provided for @cityQena.
  ///
  /// In ar, this message translates to:
  /// **'قنا'**
  String get cityQena;

  /// No description provided for @cityLuxor.
  ///
  /// In ar, this message translates to:
  /// **'الأقصر'**
  String get cityLuxor;

  /// No description provided for @cityAswan.
  ///
  /// In ar, this message translates to:
  /// **'أسوان'**
  String get cityAswan;

  /// No description provided for @cityDamietta.
  ///
  /// In ar, this message translates to:
  /// **'دمياط'**
  String get cityDamietta;

  /// No description provided for @cityPortSaid.
  ///
  /// In ar, this message translates to:
  /// **'بورسعيد'**
  String get cityPortSaid;

  /// No description provided for @citySharmElSheikh.
  ///
  /// In ar, this message translates to:
  /// **'شرم الشيخ'**
  String get citySharmElSheikh;

  /// No description provided for @cityHurghada.
  ///
  /// In ar, this message translates to:
  /// **'الغردقة'**
  String get cityHurghada;

  /// No description provided for @cityDamanhur.
  ///
  /// In ar, this message translates to:
  /// **'دمنهور'**
  String get cityDamanhur;

  /// No description provided for @cityKafrElSheikh.
  ///
  /// In ar, this message translates to:
  /// **'كفر الشيخ'**
  String get cityKafrElSheikh;

  /// No description provided for @cityMallawi.
  ///
  /// In ar, this message translates to:
  /// **'ملوي'**
  String get cityMallawi;

  /// No description provided for @cityBanha.
  ///
  /// In ar, this message translates to:
  /// **'بنها'**
  String get cityBanha;

  /// No description provided for @cityArish.
  ///
  /// In ar, this message translates to:
  /// **'العريش'**
  String get cityArish;

  /// No description provided for @cityMatruh.
  ///
  /// In ar, this message translates to:
  /// **'مطروح'**
  String get cityMatruh;

  /// No description provided for @cityQalyub.
  ///
  /// In ar, this message translates to:
  /// **'قليوب'**
  String get cityQalyub;

  /// No description provided for @cityDesouk.
  ///
  /// In ar, this message translates to:
  /// **'دسوق'**
  String get cityDesouk;

  /// No description provided for @city6October.
  ///
  /// In ar, this message translates to:
  /// **'٦ أكتوبر'**
  String get city6October;

  /// No description provided for @cityObour.
  ///
  /// In ar, this message translates to:
  /// **'العبور'**
  String get cityObour;

  /// No description provided for @cityNewCairo.
  ///
  /// In ar, this message translates to:
  /// **'القاهرة الجديدة'**
  String get cityNewCairo;

  /// No description provided for @cityHelwan.
  ///
  /// In ar, this message translates to:
  /// **'حلوان'**
  String get cityHelwan;

  /// No description provided for @searchTitle.
  ///
  /// In ar, this message translates to:
  /// **'البحث'**
  String get searchTitle;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن آية...'**
  String get searchHint;

  /// No description provided for @searchError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء البحث'**
  String get searchError;

  /// No description provided for @searchNoResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get searchNoResults;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkMode;

  /// No description provided for @toggleDarkMode.
  ///
  /// In ar, this message translates to:
  /// **'تبديل الوضع الليلي'**
  String get toggleDarkMode;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get english;

  /// No description provided for @searchSurahHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن سورة...'**
  String get searchSurahHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
