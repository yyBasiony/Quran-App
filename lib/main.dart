
import 'package:quran_app/services/quran_service.dart';
import 'package:quran_app/services/audio_service.dart';
import 'package:quran_app/services/prayer_times_service.dart';
import 'package:quran_app/services/tafsir_service.dart';
Future<void> testFetchSurahs(QuranService service) async {
  print('Fetching all surahs');
  final surahs = await service.fetchSurahs();
  surahs.forEach((surah) => print('${surah.name} - ${surah.englishName}'));
}

Future<void> testFetchSurahAyahs(QuranService service, int surahNumber) async {
  print('Fetching ayahs for Surah $surahNumber');
  final ayahs = await service.fetchSurahAyahs(surahNumber);
  ayahs.forEach((ayah) => print('${ayah.number}: ${ayah.text}'));
}

Future<void> testSearchAyah(QuranService service, String searchText) async {
  print('Searching for ayah: $searchText');
  final searchResults = await service.searchAyah(searchText);
  searchResults.isNotEmpty
      ? searchResults.forEach((ayah) => print(ayah.text))
      : print('No results found.');
}

Future<void> testFetchReciters(AudioService service) async {
  print('Fetching all reciters');
  await service.fetchReciters();
}

Future<void> testFetchSurahAudio(AudioService service, int reciterId, int surahNumber) async {
  print('Fetching audio for Surah $surahNumber by Reciter $reciterId');
  final audio = await service.fetchSurahAudio(reciterId, surahNumber);
  if (audio != null && audio.audioUrl.isNotEmpty) {
    print('Reciter: ${audio.reciterName}');
    print('Audio URL: ${audio.audioUrl}');
  } else {
    print('No audio found.');
  }
}

Future<void> testFetchPrayerTimes(PrayerTimesService service, String city, String country) async {
  print('Fetching prayer times for $city, $country...');
  final prayerTimes = await service.fetchPrayerTimes(city, country);
  print('Fajr: ${prayerTimes.fajr}');
  print('Dhuhr: ${prayerTimes.dhuhr}');
  print('Asr: ${prayerTimes.asr}');
  print('Maghrib: ${prayerTimes.maghrib}');
  print('Isha: ${prayerTimes.isha}');
}

Future<void> testFetchTafsir(TafsirService service, int surah, int ayah) async {
  print('Fetching Tafsir for Surah $surah, Ayah $ayah');
  final tafsir = await service.fetchTafsir(surah, ayah);
  tafsir != null
      ? print('Tafsir: ${tafsir.text}')
      : print('No Tafsir found.');
}

void main() async {
  final quranService = QuranService();
  final audioService = AudioService();
  final prayerService = PrayerTimesService();
  final tafsirService = TafsirService();

  try {
        print('---------------------------------------');

    await testFetchSurahs(quranService);
        print('---------------------------------------');

    await testFetchSurahAyahs(quranService, 114);
        print('---------------------------------------');

    await testSearchAyah(quranService, 'ربنا وابعث فيهم');
        print('---------------------------------------');

    await testFetchReciters(audioService);
        print('---------------------------------------');

    await testFetchSurahAudio(audioService, 54, 114);
        print('---------------------------------------');

    await testFetchPrayerTimes(prayerService, 'zagazig', 'Egypt');
        print('---------------------------------------');

    await testFetchTafsir(tafsirService, 3, 114);
  } catch (e) {
    print('Error: $e');
  }
}

