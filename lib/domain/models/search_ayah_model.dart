class SearchAyahModel {
  final String text;
  final int? surah;
  final int? ayah;

  SearchAyahModel({
    required this.text,
    this.surah,
    this.ayah,
  });

  factory SearchAyahModel.fromJson(dynamic json) {
    if (json is String) {
      return SearchAyahModel(text: json);
    } else if (json is Map<String, dynamic>) {
      return SearchAyahModel(
        text: json['text'] ?? '',
        surah: json['surah'],
        ayah: json['ayah'],
      );
    } else {
      throw Exception("Invalid ayah JSON");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'surah': surah,
      'ayah': ayah,
    };
  }
}
