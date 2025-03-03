class AudioModel {
  final String reciterName;
  final String audioUrl;
  final int surahNumber;

  AudioModel({
    required this.reciterName,
    required this.audioUrl,
    required this.surahNumber,
  });

factory AudioModel.fromJson(Map<String, dynamic> json, int requestedSurah) {
  if (json['moshaf'] != null && (json['moshaf'] as List).isNotEmpty) {
    var moshaf = json['moshaf'][0]; 

    List<String> surahList = (moshaf['surah_list'] as String).split(',');

    String audioUrl = '';
    if (surahList.contains(requestedSurah.toString())) {
      audioUrl = "${moshaf['server']}${requestedSurah.toString().padLeft(3, '0')}.mp3";
    }

    return AudioModel(
      reciterName: json['name'] ?? 'Unknown',
      audioUrl: audioUrl,
      surahNumber: requestedSurah,
    );
  } else {
    return AudioModel(
      reciterName: json['name'] ?? 'Unknown',
      audioUrl: '',
      surahNumber: requestedSurah,
    );
  }
}
}
