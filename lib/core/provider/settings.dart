import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingServicesProvider with ChangeNotifier {
  ThemeMode currentMode = ThemeMode.dark;
  static const String _themeKey = 'theme_mode';

  SettingServicesProvider() {
    _loadSettings();
  }


  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey);
    if (isDark != null) {
      currentMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }


    notifyListeners();
  }


  Future<void> updateTheme(ThemeMode mode) async {
    if (currentMode == mode) return;
    currentMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  bool get isDark => currentMode == ThemeMode.dark;


}