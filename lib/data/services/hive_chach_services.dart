import 'package:hive/hive.dart';

import 'base_cache_services.dart';

class HiveCacheService extends BaseCacheService {
  final String boxName;

  HiveCacheService(this.boxName);

  @override
  Future<void> saveData(String key, dynamic value) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<dynamic> getData(String key) async {
    final box = await Hive.openBox(boxName);
    return box.get(key);
  }
}
