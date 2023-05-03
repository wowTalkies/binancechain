import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  PreferenceHelper._();

  static Future saveWalletRequestFrom(String? fromTab) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("fromTab", fromTab!);
  }

  static Future<String?> getWalletRequestFrom() async {
    String? value;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getString("fromTab");
    if (value?.isEmpty ?? true) {
      return null;
    } else {
      return value;
    }
  }

  /// get a current user token
  static Future<String?> getToken() async {
    String? value;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getString("token");
    if (value?.isEmpty ?? true) {
      return null;
    } else {
      return value;
    }
  }

  static Future<String?> getUserId() async {
    String? value;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getString("uid");
    if (value?.isEmpty ?? true) {
      return null;
    } else {
      return value;
    }
  }

  static Future saveUserId(String? id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (id == null) return;
    pref.setString("uid", id);
  }

  static Future saveNodeUrl(String? node) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (node == null) return;
    pref.setString("node", node);
  }

  /// Save a token
  static Future saveToken(String? token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (token == null) return;
    pref.setString("token", token);
  }

  static Future<String?> getNodeUrl() async {
    String? value;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getString("node");
    if (value?.isEmpty ?? true) {
      return null;
    } else {
      return value;
    }
  }

  /// get a current user wallet token
  static Future<String?> getWalletToken() async {
    String? value;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getString("wallet_token");
    if (value?.isEmpty ?? true) {
      return null;
    } else {
      debugPrint('the address is ');
      return value;
    }
  }

  static Future<void> saveHideOnboarding({required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hide_onboarding", value);
  }

  static Future<bool> getHideOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("hide_onboarding") ?? false;
  }

  static Future<void> saveTheme({required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_dark", value);
  }

  static Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_dark") ?? false;
  }

  /// Save a wallet token
  static Future saveWalletToken(String? token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (token == null) return;
    pref.setString("wallet_token", token);
  }

  /// Clear a storage
  static Future clearStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    //await prefs.setBool("isSeen", true);
  }


}
