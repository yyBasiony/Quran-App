  class TafsirModel {
  final int number;
  final String text;
  final String edition;
  final int surah;
  final int ayah;

  TafsirModel({
    required this.number,
    required this.text,
    required this.edition,
    required this.surah,
    required this.ayah,
  });

  factory TafsirModel.fromJson(Map<String, dynamic> json) {
    print('Raw Tafsir JSON: $json');

    return TafsirModel(
      number: json['number'] ?? 0,
      text: json['text'] ?? 'لا يوجد نص تفسير',
      edition: json['edition']?['name'] ?? 'غير معروف',
      surah: json['surah']?['number'] ?? 0,
      ayah: json['numberInSurah'] ?? 0,
    );
  }
}


