class AudioInfo {
  final int surahNumber;
  final int reciterId;
  final String audioUrl;
  final String reciterName;

  AudioInfo({
    required this.surahNumber,
    required this.reciterId,
    required this.audioUrl,
    required this.reciterName,
  });

  Map<String, dynamic> toJson() {
    return {
      'surahNumber': surahNumber,
      'reciterId': reciterId,
      'audioUrl': audioUrl,
      'reciterName': reciterName,
    };
  }

  factory AudioInfo.fromJson(Map<String, dynamic> json) {
    return AudioInfo(
      surahNumber: json['surahNumber'],
      reciterId: json['reciterId'],
      audioUrl: json['audioUrl'],
      reciterName: json['reciterName'],
    );
  }
}