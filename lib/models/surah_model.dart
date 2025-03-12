import 'package:hive/hive.dart';

part 'surah_model.g.dart';

@HiveType(typeId: 0)
class SurahModel {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String englishName;

  SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
    };
  }
}