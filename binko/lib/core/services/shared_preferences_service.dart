import 'package:shared_preferences/shared_preferences.dart';

import '../constants/shared_preferences_keys.dart';
import '../extensions/string_parser.dart';

class SharedPreferencesService {
  SharedPreferencesService._();

  static late final SharedPreferences _sp;

  static Future<void> init() async =>
      _sp = await SharedPreferences.getInstance();

  static Future<void> storeLanguage(String code) async {
    await _sp.setString(AppKeys.language, code);
  }

  static String getLanguage() {
    return _sp.getString(AppKeys.language) ?? 'en';
  }

  static Future<void> storeTheme(String code) async {
    await _sp.setString(AppKeys.theme, code);
  }

  static String getTheme() {
    return _sp.getString(AppKeys.theme) ?? 'light';
  }

  static removeToken() async {
    await _sp.remove(AppKeys.token);
  }

  static Future<void> clear() async {
    await _sp.remove(AppKeys.idForOTP);
    await _sp.remove(AppKeys.token);
    await _sp.remove(AppKeys.currencySymbol);
    await _sp.remove(AppKeys.idCurrency);
  }

  static Future<void> storeToken(String token) async {
    await _sp.setString(AppKeys.token, token);
  }

  static String? getToken() {
    return _sp.getString(AppKeys.token);
  }

  static Future<void> storeFcmToken(String token) async {
    await _sp.setString(AppKeys.fcmToken, token);
  }

  static String? getFcmToken() {
    return _sp.getString(AppKeys.fcmToken);
  }

  static Future<void> storeIdForOTP(int idForOTP) async {
    await _sp.setInt(AppKeys.idForOTP, idForOTP);
  }

  static int? getIdForOTP() {
    return _sp.getInt(AppKeys.idForOTP);
  }

  static Future<void> storeCurrencySymbol(String currencySymbol) async {
    await _sp.setString(AppKeys.currencySymbol, currencySymbol);
  }

  static Future<void> storeShareLink(String currencySymbol) async {
    await _sp.setString(AppKeys.shareLink, currencySymbol);
  }

  static String getShareLink() {
    return _sp.getString(AppKeys.shareLink) ?? 'https://ewaiq-dev.vercel.app/';
  }

  static Future<void> storeProfitPercentage(String currencySymbol) async {
    await _sp.setDouble(AppKeys.profitPercentage,
        (num.tryParse(currencySymbol)?.toDouble() ?? 0) / 100);
  }

  static double getProfitPercentage() {
    return _sp.getDouble(AppKeys.profitPercentage) ?? 0;
  }

  static bool isSettedCurrency() {
    return _sp.getString(AppKeys.currencySymbol) != null;
  }

  static String? getCurrencySymbol() {
    return (_sp.getString(AppKeys.currencySymbol) ?? '\$').parseUnicode();
  }

  static Future<void> storeIdCurrency(int idCurrency) async {
    await _sp.setInt(AppKeys.idCurrency, idCurrency);
  }

  static int? getIdCurrency() {
    return _sp.getInt(AppKeys.idCurrency);
  }

  static Future<void> storeFirstTimeDetails() async {
    await _sp.setBool(AppKeys.firstTimeDetails, true);
  }

  static bool getFirstTimeDetails() {
    return _sp.getBool(AppKeys.firstTimeDetails) ?? false;
  }

  static Future<void> storeFirstTimeQoutation() async {
    await _sp.setBool(AppKeys.firstTimeQoutation, true);
  }

  static bool getFirstTimeQoutation() {
    return _sp.getBool(AppKeys.firstTimeQoutation) ?? false;
  }
}
