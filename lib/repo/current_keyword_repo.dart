import 'package:shared_preferences/shared_preferences.dart';

class CurrentKeywordRepository {
  static const String _key = 'currentKeyword';

  final SharedPreferences _preferences;

  CurrentKeywordRepository(this._preferences);

  Future<void> setCurrentKeyword(List<String> currentKeywordList) async {
    _preferences.setStringList(_key, currentKeywordList);
  }

  List<String> getCurrentKeywords() {
    return _preferences.getStringList(_key) ?? [];
  }
}
