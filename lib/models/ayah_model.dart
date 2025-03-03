
class AyahModel {
  final int number;
  final String text;
  final int surahNumber;

  AyahModel({
    required this.number,
    required this.text,
    required this.surahNumber,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'] ?? 0,
      text: json['text'] ?? '',
      surahNumber: json['surah']?['number'] ?? 0,
    );
  }
}
