import 'package:meminder/app/functions/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setString(String key, String value) {
  locator<SharedPreferences>().setString(key, value);
}

String? getString(String key) {
  return locator<SharedPreferences>().getString(key);
}

void setBool(String key, bool value) {
  locator<SharedPreferences>().setBool(key, value);
}

bool? getBool(String key) {
  return locator<SharedPreferences>().getBool(key);
}
