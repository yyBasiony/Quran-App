# quran_app
#  Qanet -قَانِت -Islamic Flutter App

**Qanet** is a Flutter-based Islamic application designed to provide essential religious utilities including Quran Surah display, audio recitations, prayer times, and Ayah search. The app supports localization (Arabic/English), dark/light mode, and offline access for enhanced user experience.

---

##  Features

-  List of all Surahs from the Quran .
-  Play Surah audio from selected reciters using MP3Quran API.
-  Audio downloads and offline playback.
-  Accurate prayer times based on user's city .
-  Search Ayahs by keyword with instant results.
-  Full support for light and dark themes.
-  Localization (Arabic & English) using `.arb` files.
-  Hive caching for Surahs and Ayahs.
-  Responsive layout using `flutter_screenutil`.

---

##  Dependencies

```yaml
flutter:
  sdk: flutter
flutter_localizations:
  sdk: flutter
hive: ^2.2.3
hive_flutter: ^1.1.0
http: ^0.13.6
path_provider:
provider:
audioplayers:
intl:
shared_preferences:
font_awesome_flutter:
flutter_screenutil:
dropdown_button2:
```

---

##  Localization Support

Qanet supports multilingual translations through `.arb` files and `AppLocalizations`. It is fully configured for internationalization:

```yaml
flutter:
  generate: true
  arb-dir: lib/l10n
  template-arb-file: app_ar.arb
  template-en-file: app_en.arb
  output-localization-file: app_localizations.dart
  output-class: AppLocalizations
```

---

##  Light & Dark Mode

The app uses a dedicated `AppTheme` with color schemes defined in `AppColors` for both light and dark modes.

```dart
ThemeData get lightTheme => ThemeData(...);
ThemeData get darkTheme => ThemeData(...);
```

---



##  Code Highlights

Here are some of the standout implementations in the project code:

###  1. Efficient Data Caching with Hive

Caches Surahs and Ayahs locally for offline access.

```dart
final box = await Hive.openBox<SurahModel>('surahsBox');
if (box.isNotEmpty)
  return box.values.toList();
```

###  2.  Filtering of Reciters by Surah Availability

Only displays reciters who have the selected Surah.

```dart
if (surahs.contains(surahNumber.toString())) {
  return true;
}
```

###  3.  Localization 

Integrated ARB files and custom localization generation.

```yaml
arb-dir: lib/l10n
template-arb-file: app_ar.arb
template-en-file: app_en.arb
```

###  4. Theme Management

Custom colors, text styles, and themes for light and dark modes.

```dart
ThemeData get darkTheme => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
);
```

###  5. Dynamic Audio URL Generation

Builds the audio URL using the reciter server + Surah number.

```dart
audioUrl = "${json['server']}${requestedSurah.toString().padLeft(3, '0')}.mp3";
```

###  6.  Offline Audio Download

Checks and stores audio locally to avoid unnecessary API calls.

```dart
if (await File(filePath).exists())
  return filePath;

final response = await http.get(Uri.parse(audioUrl));
await file.writeAsBytes(response.bodyBytes);
```

###  7.  Ayah Search Integration

Search Ayahs using a separate public API.

```dart
final response = await http.get(
  Uri.parse('https://api-quran.com/api?text=$searchText&type=search'));
```









