# quran_app
#  Qanet -قَانِت -Islamic Flutter App

**Qanet** is a simple Flutter-based Islamic app that provides core religious features to support daily worship.

This app helps users by:
- Showing accurate **prayer times** by city, with the **next upcoming prayer highlighted** in a large card.
- Displaying **Quranic Ayahs** both in **text** and **audio form**, supporting playback from **multiple reciters**.
- Allowing users to **search for Ayahs** using any keyword.
- Supporting **two languages**: Arabic and English (Localization).
- Providing both **Light and Dark modes** to enhance usability and user comfort.
- Enabling **offline access after initial download**, so users can continue reading and listening without an active internet connection.

Whether you're looking to check the prayer time, listen to a recitation, or search an Ayah — Qanet offers a clean, focused, and user-friendly experience.
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
## 8. State Management: `Provider`

<h3> UI Screenshots</h3>

<p align="center">
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/1.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/2.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/3.jpg" width="30%" style="margin: 10px;" />
</p>
<p align="center">
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/4.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/5.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/6.jpg" width="30%" style="margin: 10px;" />
</p>
<p align="center">
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/7.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/8.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/9.jpg" width="30%" style="margin: 10px;" />
</p>
<p align="center">
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/10.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/11.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/12.jpg" width="30%" style="margin: 10px;" />
</p>
<p align="center">
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/13.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/14.jpg" width="30%" style="margin: 10px;" />
  <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/15.jpg" width="30%" style="margin: 10px;" />
   <img src="https://github.com/yyBasiony/Quran-App/blob/main/assets/images/16.jpg" width="30%" style="margin: 10px;" />

</p>


### 10 Author 
##This application was developed by Yasmine Ibrahim with technical mentorship and guidance from Eng. Yousef Sayed.















