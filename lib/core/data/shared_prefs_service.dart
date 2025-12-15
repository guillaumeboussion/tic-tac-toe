import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/data/shared_prefs_data_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe_app/core/data/typedefs.dart';

final sharedPrefsServiceProvider = Provider((ref) => SharedPrefsService());

class SharedPrefsService {
  SharedPreferences? sharedPreferences;

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveData({required String key, required Object value, required SharedPrefsDataType dataType}) async {
    // We know that the return type will always be Future<bool>
    return getSetMethod(sharedPrefsMethod: dataType)(key, value) as Future<bool>;
  }

  Future<dynamic> restoreData({required String key, required SharedPrefsDataType dataType}) async {
    return getGetMethod(sharedPrefsMethod: dataType)(key);
  }

  Future<bool> clearAll() async {
    return sharedPreferences!.clear();
  }

  Future<bool> clearKey({required String key}) async {
    return sharedPreferences!.remove(key);
  }

  // ignore: always_declare_return_types
  getSetMethod({required SharedPrefsDataType sharedPrefsMethod}) {
    switch (sharedPrefsMethod) {
      case SharedPrefsDataType.string:
        return sharedPreferences!.setString;
      case SharedPrefsDataType.int:
        return sharedPreferences!.setInt;
      case SharedPrefsDataType.double:
        return sharedPreferences!.setDouble;
      case SharedPrefsDataType.bool:
        return sharedPreferences!.setBool;
      case SharedPrefsDataType.stringList:
        return sharedPreferences!.setStringList;
    }
  }

  GetMethod getGetMethod({required SharedPrefsDataType sharedPrefsMethod}) {
    switch (sharedPrefsMethod) {
      case SharedPrefsDataType.string:
        return sharedPreferences!.getString;
      case SharedPrefsDataType.int:
        return sharedPreferences!.getInt;
      case SharedPrefsDataType.double:
        return sharedPreferences!.getDouble;
      case SharedPrefsDataType.bool:
        return sharedPreferences!.getBool;
      case SharedPrefsDataType.stringList:
        return sharedPreferences!.getStringList;
    }
  }
}
