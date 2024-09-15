import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static SharedPreferences? _preferences;

  // Initialize the SharedPreferences instance (only once)
  static Future<void> init() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  // Retrieve the value of a given key (generic type)
  static T? getValue<T>(String key) {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }

    if (T == String) {
      return _preferences!.getString(key) as T?;
    } else if (T == int) {
      return _preferences!.getInt(key) as T?;
    } else if (T == bool) {
      return _preferences!.getBool(key) as T?;
    } else if (T == double) {
      return _preferences!.getDouble(key) as T?;
    } else if (T == List<String>) {
      return _preferences!.getStringList(key) as T?;
    } else {
      return null;
    }
  }

  static Future<void> clearPreferences() async {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }
    await _preferences!.clear();
  }
}
