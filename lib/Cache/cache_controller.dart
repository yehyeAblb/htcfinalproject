import 'package:shared_preferences/shared_preferences.dart';

import '../enums.dart';

class CacheController {
  ///SINGLETON
  CacheController._();
  static CacheController cache = CacheController._();
  factory CacheController()=> cache;
  /// CACHE
  late SharedPreferences preferences;

  Future<void> initCache() async {
    preferences = await SharedPreferences.getInstance();
  }
  ///Data
  Future<void> setter(CacheKey Key, dynamic value) async {
    if (value is String) {
      await preferences.setString(Key.name, value);
    } else if (value is int) {
      await preferences.setInt(Key.name, value);
    } else if (value is double) {
      await preferences.setDouble(Key.name, value);
    } else if (value is bool) {
      await preferences.setBool(Key.name, value);
    }
  }

  dynamic getter (CacheKey Key)  => preferences.get(Key.name);

  Future<void> setLanguage(String language) async{
    await preferences.setString(CacheKey.language.name, language);
  }
  String get getLanguage => preferences.getString(CacheKey.language.name) ?? 'ar' ;


Future<void> login() async {
  await preferences.setBool(CacheKey.LoggedIn.name, true);
 }
bool get getLogin => preferences.getBool(CacheKey.LoggedIn.name) ?? false;
  Future<void> logout() async =>
      await preferences.setBool(CacheKey.LoggedIn.name, false);
}