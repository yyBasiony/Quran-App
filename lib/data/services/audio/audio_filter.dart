import '../../models/audio_mobel.dart';

class AudioFilter{
  static List<dynamic> filterRecitersBySurah(List<dynamic> recitersJson, int surahNumber) {
    return recitersJson.where((reciter) {
      final moshafList = reciter['moshaf'] as List<dynamic>?;
      if (moshafList == null || moshafList.isEmpty) return false;

      return moshafList.any((moshaf) {
        final surahList = moshaf['surah_list'];
        if (surahList == null) return false;

        final surahs = surahList.toString().split(',').map((e) => e.trim());
        return surahs.contains(surahNumber.toString());
      });
    }).toList();
  }

  static List<AudioModel> mapToAudioModels(List<dynamic> data, int surahNumber) {
    return data
        .map((reciter) => AudioModel.fromJson(
              Map<String, dynamic>.from(reciter),
              surahNumber,
            ))
        .toList();
  }
}
