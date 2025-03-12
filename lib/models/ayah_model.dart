import 'package:hive/hive.dart';

part 'ayah_model.g.dart';

@HiveType(typeId: 1) 
class AyahModel {
  @HiveField(0)
  final int number;
  
  @HiveField(1)
  final String text;

  AyahModel({required this.number, required this.text});

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
    };
  }
}
