import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/service_locator/service_locator.dart';
import 'package:locum_app/core/static_data/shared_prefrences_key.dart';
import 'package:locum_app/core/themes/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme) {
    _loadTheme();
  }

  void toggleTheme() {
    final prefs = serviceLocator<SharedPreferences>();
    if (state.brightness == Brightness.light) {
      emit(darkTheme);
      prefs.setBool(ShPrefKey.isDarkMode, true);
    } else {
      emit(lightTheme);
      prefs.setBool(ShPrefKey.isDarkMode, false);
    }
  }

  void _loadTheme() {
    final prefs = serviceLocator<SharedPreferences>();
    final isDarkMode = prefs.getBool(ShPrefKey.isDarkMode) ?? false;
    emit(isDarkMode ? darkTheme : lightTheme);
  }

  bool isDarkMode() {
    final prefs = serviceLocator<SharedPreferences>();
    final isDarkMode = prefs.getBool(ShPrefKey.isDarkMode) ?? false;
    return isDarkMode;
  }
}
