import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String DARKTHEME = 'dark_theme';
  Prefs._privateConstructor();
  static final Prefs instance = Prefs._privateConstructor();
  // static SharedPreferences _prefs;
  // static Map<String, dynamic> _memoryPrefs = Map<String, dynamic>();

  // static Future<SharedPreferences> load() async {
  //   if (_prefs == null) {
  //     _prefs = await SharedPreferences.getInstance();
  //   }
  //   return _prefs;
  // }

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  removeAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }
  // static setString(String key, String value) {
  //   _prefs.setString(key, value);
  //   _memoryPrefs[key] = value;
  // }

  // static void setInt(String key, int value) {
  //   _prefs.setInt(key, value);
  //   _memoryPrefs[key] = value;
  // }

  // static void setDouble(String key, double value) {
  //   _prefs.setDouble(key, value);
  //   _memoryPrefs[key] = value;
  // }

  // static void setBool(String key, bool value) {
  //   _prefs.setBool(key, value);
  //   _memoryPrefs[key] = value;
  // }

  // static String getString(String key, {String def}) {
  //   String val;

  //   //Attempt to fetch val from memory
  //   if (_memoryPrefs.containsKey(key)) {
  //     val = _memoryPrefs[key];
  //   }

  //   //Attempt to fetch val directly from shared preference
  //   if (val == null) {
  //     val = _prefs.getString(key);
  //   }

  //   //Set val to default
  //   if (val == null) {
  //     val = def;
  //   }
  //   _memoryPrefs[key];

  //   return val;
  // }

  // static int getInt(String key, {int def}) {
  //   int val;

  //   //Attempt to fetch val from memory
  //   if (_memoryPrefs.containsKey(key)) {
  //     val = _memoryPrefs[key];
  //   }

  //   //Attempt to fetch val directly from shared preference
  //   if (val == null) {
  //     val = _prefs.getInt(key);
  //   }

  //   //Set val to default
  //   if (val == null) {
  //     val = def;
  //   }
  //   _memoryPrefs[key];

  //   return val;
  // }

  // static double getDouble(String key, {double def}) {
  //   double val;

  //   //Attempt to fetch val from memory
  //   if (_memoryPrefs.containsKey(key)) {
  //     val = _memoryPrefs[key];
  //   }

  //   //Attempt to fetch val directly from shared preference
  //   if (val == null) {
  //     val = _prefs.getDouble(key);
  //   }

  //   //Set val to default
  //   if (val == null) {
  //     val = def;
  //   }
  //   _memoryPrefs[key];

  //   return val;
  // }

  // static bool getBool(String key, {bool def}) {
  //   bool val;

  //   //Attempt to fetch val from memory
  //   if (_memoryPrefs.containsKey(key)) {
  //     val = _memoryPrefs[key];
  //   }

  //   //Attempt to fetch val directly from shared preference
  //   if (val == null) {
  //     val = _prefs.getBool(key);
  //   }

  //   //Set val to default
  //   if (val == null) {
  //     val = def;
  //   }
  //   _memoryPrefs[key];

  //   return val;
  // }
}
