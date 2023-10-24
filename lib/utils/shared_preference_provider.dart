// shared_preference_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider {
  static Future<SharedPreferences> get instance async =>
      await SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async {
    final pref = await instance;
    await pref.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final pref = await instance;
    return pref.getString(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    final pref = await instance;
    await pref.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    final pref = await instance;
    return pref.getStringList(key);
  }

  Future<void> setInt(String key, int value) async {
    final pref = await instance;
    await pref.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final pref = await instance;
    return pref.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    final pref = await instance;
    await pref.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final pref = await instance;
    return pref.getBool(key);
  }
}

// Provider 생성
// cakesRepo 라는 이름으로, CakesRepo 클래스를 Provider로 등록
final sharedPreferenceRepo = Provider((ref) => SharedPreferenceProvider());
