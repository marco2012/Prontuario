import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {

  loadPreference(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString(name) ?? '');
  }

  setPreference(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
