import 'dart:convert';
import '../../../app/app_preferences.dart';
import 'base_cache_services.dart';

class SharedPrefsCacheService extends BaseCacheService {
  final _prefs = AppPreferences.prefs;

  @override
  Future<void> saveData(String key, dynamic value) async {
    final jsonString = jsonEncode(value);
    await _prefs.setString(key, jsonString);
  }

  @override
  Future<dynamic> getData(String key) async {
    final jsonString = _prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
}
