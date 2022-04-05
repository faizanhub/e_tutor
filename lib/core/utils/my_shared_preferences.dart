import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static String sharedPreferenceUserNameKey = AppConfigs.userNameKey;

  static SharedPreferences? _preferences;

  /// saving data to sharedpreference

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    return await _preferences!.setString(sharedPreferenceUserNameKey, userName);
  }

  /// fetching data from sharedpreference

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String getUserNameSharedPreference() {
    return _preferences!.getString(sharedPreferenceUserNameKey) ?? '';
  }
}
