import '../../data/models/audio_mobel.dart';
import '../../data/models/ayah_model.dart';

class SurahContentResult {
  final List<AyahModel> ayahs;
  final List<AudioModel> reciters;
  final bool hasFailed;
  final String? errorMessage;

  SurahContentResult({
    required this.ayahs,
    required this.reciters,
    required this.hasFailed,
    this.errorMessage,
  });
}
