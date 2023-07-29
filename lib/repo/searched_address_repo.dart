import 'package:shared_preferences/shared_preferences.dart';

class SearchedAddressRepository {
  // static const String searchedAddressListKey = 'searcedAddressList';
  static const String searcedHistoryAddressListKey =
      'searcedHistoryAddressList';

  final SharedPreferences _preferences;

  SearchedAddressRepository(this._preferences);

  // Future<void> setSearchedAddressList(List<String> searchedAddressList) async {
  //   _preferences.setStringList(searchedAddressListKey, searchedAddressList);
  // }

  Future<void> setSearchedHistoryAddressList(
      List<String> searchedHistoryAddressList) async {
    _preferences.setStringList(
        searcedHistoryAddressListKey, searchedHistoryAddressList);
  }

  // List<String> getSearchedAddressList() {
  //   return _preferences.getStringList(searchedAddressListKey) ?? [];
  // }

  List<String> getSearchedHistoryAddressList() {
    return _preferences.getStringList(searcedHistoryAddressListKey) ?? [];
  }
}
