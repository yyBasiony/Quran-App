class AudioModel {
  final String reciterName;
  final int reciterId;
  final int surahNumber;
  final List<MoshafModel> moshafs;
  final String audioUrl;

  AudioModel({
    required this.reciterName,
    required this.reciterId,
    required this.surahNumber,
    required this.moshafs,
    required this.audioUrl,
  });

factory AudioModel.fromJson(Map<String, dynamic> json, int requestedSurah) {
  List<MoshafModel> moshafList = [];

  if (json['moshaf'] != null && (json['moshaf'] as List).isNotEmpty) {
    moshafList = (json['moshaf'] as List)
        .map((moshaf) => MoshafModel.fromJson(moshaf, requestedSurah))
        .where((moshaf) => moshaf.audioUrl.isNotEmpty)
        .toList();
  }

  if (moshafList.isEmpty) {
    throw Exception("No surah audio for this reciter");
  }

  String firstAudioUrl = moshafList.first.audioUrl;

  return AudioModel(
    reciterName: json['name'] ?? 'Unknown',
    reciterId: json['id'],
    surahNumber: requestedSurah,
    moshafs: moshafList,
    audioUrl: firstAudioUrl,
  );
}
}

class MoshafModel {
  final int id;
  final String name;
  final String audioUrl;

  MoshafModel({
    required this.id,
    required this.name,
    required this.audioUrl,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json, int requestedSurah) {
    List<String> surahList = (json['surah_list'] as String).split(',');
    String audioUrl = '';

    if (surahList.contains(requestedSurah.toString())) {
      audioUrl = "${json['server']}${requestedSurah.toString().padLeft(3, '0')}.mp3";
    }

    return MoshafModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Moshaf',
      audioUrl: audioUrl,
    );
  }
}
