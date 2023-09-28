import 'package:flutter/material.dart';
import 'package:yehyefirebasee/Cache/cache_controller.dart';
import 'package:yehyefirebasee/enums.dart';

class ThemeProvider extends ChangeNotifier{
  int theme = CacheController().getter(CacheKey.theme) ?? 1;
  Future<void> get changeTheme async {
    theme = theme == 1 ? 0 : 1;
    await CacheController().setter(CacheKey.theme, theme);
    notifyListeners();
  }
  Color get mainTextColor => theme ==1 ? Colors.black : Colors.white;
}