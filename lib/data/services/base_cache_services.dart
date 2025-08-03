abstract class BaseCacheService {
  Future<void> saveData(String key, dynamic value);
  Future<dynamic> getData(String key);
}
