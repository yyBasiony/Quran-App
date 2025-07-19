import 'package:flutter/material.dart';
import 'package:qanet/data/models/audio_mobel.dart';
import 'package:qanet/data/models/ayah_model.dart';
import 'package:qanet/data/models/surah_model.dart';
import 'package:qanet/data/services/audio_service.dart';
import 'package:qanet/data/services/quran_service.dart';

class SurahLogic {
  static final QuranService _quranService = QuranService();
  static final AudioService _audioService = AudioService();

  static Future<List<SurahModel>> fetchSurahs({BuildContext? context}) async {
    return await _quranService.fetchSurahs(context: null); 
  }

  static String removeDiacritics(String text) {
    return text.replaceAll(RegExp(r'[\u064B-\u065F\u0610-\u061A\u06D6-\u06ED]'), '');
  }

  static List<SurahModel> filterSurahs(List<SurahModel> surahs, String query) {
    final normalizedQuery = removeDiacritics(query.toLowerCase().trim());
    return surahs.where((surah) {
      final arabicName = removeDiacritics(surah.name.toLowerCase().trim());
      final englishName = surah.englishName.toLowerCase().trim();
      return arabicName.contains(normalizedQuery) || englishName.contains(normalizedQuery);
    }).toList();
  }

  static Future<List<AyahModel>> fetchAyahs(int surahNumber, {BuildContext? context}) async {
    return await _quranService.fetchSurahAyahs(surahNumber, context: context);
  }

  static Future<List<AudioModel>> fetchReciters({BuildContext? context}) async {
    return await _audioService.fetchReciters(context: context);
  }

  static Future<List<AudioModel>> fetchRecitersWithSurah(int surahNumber, {BuildContext? context}) async {
    return await _audioService.fetchRecitersWithSurah(surahNumber, context: context);
  }

  static Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber, {BuildContext? context}) async {
    return await _audioService.fetchSurahAudio(reciterId, surahNumber, context: context);
  }

  static Future<String> getOrDownloadAudio(String url, String fileName, {BuildContext? context}) async {
    return await _audioService.getOrDownloadAudio(url, fileName, context: context);
  }
}
