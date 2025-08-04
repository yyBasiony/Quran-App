import '../../models/surah_model.dart';

abstract class ISurahService {
  Future<List<SurahModel>> fetchSurahs();
}
