import 'dart:convert';

import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/service_locator/service_locator.dart';
import 'package:locum_app/core/static_data/shared_prefrences_key.dart';
import 'package:locum_app/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelpers {
  static void cacheUser(UserModel user) {
    final prefs = serviceLocator<SharedPreferences>();
    prefs.setString(ShPrefKey.user, jsonEncode(user.toJson()));
    if (user.token != null) prefs.setString(ShPrefKey.token, user.token!);
  }

  static UserModel? getCachedUser() {
    final t = prt('getCachedUser - AuthHelpers');
    try {
      final prefs = serviceLocator<SharedPreferences>();
      String? userRawData = prefs.getString(ShPrefKey.user);
      if (userRawData == null) {
        pr('No user cached in the memory', t);
        return null;
      }
      UserModel user = UserModel.fromJson(jsonDecode(userRawData));
      return pr(user, t);
    } catch (e) {
      pr('Exception: $e', t);
      return null;
    }
  }

  static String? getCachedToken() {
    final t = prt('getCachedToken - AuthHelpers');
    final prefs = serviceLocator<SharedPreferences>();
    String? token = prefs.getString(ShPrefKey.token);
    return pr(token, t);
  }

  static bool isSignedIn() {
    return getCachedToken() == null ? false : true;
  }
}