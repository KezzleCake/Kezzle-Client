// import 'package:kezzle/models/search_setting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchSettingRepository {
  // late SharedPreferences _preferences;
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';
  static const String addressKey = 'address';
  static const String radiusKey = 'radius';

  final SharedPreferences _preferences;

  SearchSettingRepository(this._preferences);

  // SearchSettingRepository() {
  //   SharedPreferences.getInstance().then((value) => _preferences = value);
  // }

  Future<void> setAddress(String address) async {
    _preferences.setString(addressKey, address);
  }

  Future<void> setLatitude(double latitude) async {
    _preferences.setDouble(latitudeKey, latitude);
  }

  Future<void> setLongitude(double longitude) async {
    _preferences.setDouble(longitudeKey, longitude);
  }

  Future<void> setRadius(int radius) async {
    _preferences.setInt(radiusKey, radius);
  }

  String getAddress() {
    return _preferences.getString(addressKey) ?? '';
  }

  double getLatitude() {
    return _preferences.getDouble(latitudeKey) ?? 0.0;
  }

  double getLongitude() {
    return _preferences.getDouble(longitudeKey) ?? 0.0;
  }

  int getRadius() {
    return _preferences.getInt(radiusKey) ?? 5;
  }
}
