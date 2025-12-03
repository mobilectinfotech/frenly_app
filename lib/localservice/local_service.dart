import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
///Pramod Code

class LocaleService {
  static const String _key = 'locale';

  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  Future<Locale?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_key);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null;
  }
}



// class LocaleService {
//   static const String _key = 'locale';
//
//   Future<void> saveLocale(Locale locale) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_key, locale.languageCode); // saves "en" or "sv"
//   }
//
//   Future<Locale?> getLocale() async {
//     final prefs = await SharedPreferences.getInstance();
//     final code = prefs.getString(_key);
//
//     if (code != null) {
//       return Locale(code, code == "sv" ? "SE" : "US");
//     }
//     return null;
//   }
// }
