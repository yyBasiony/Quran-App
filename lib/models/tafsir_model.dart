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
    return TafsirModel(
      number: json['number'],
      text: json['text'],
      edition: json['edition']['name'],
      surah: json['surah']['number'],
      ayah: json['numberInSurah'],
    );
  }
}
