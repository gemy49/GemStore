import 'package:shared_preferences/shared_preferences.dart';
String? token='';
class CacheHelper{
  static SharedPreferences? sharedPreferences;
  static init()async{
    sharedPreferences= await SharedPreferences.getInstance();
  }
  static Future<bool> setData(
      {
        required dynamic value,
        required String key,
      }
      )async
  {
   if(value is bool) return await sharedPreferences!.setBool(key, value);
   if(value is String) return await sharedPreferences!.setString(key, value);
   if(value is double) return await sharedPreferences!.setDouble(key, value);
    return await sharedPreferences!.setInt(key, value);
  }
  static dynamic getData({required String key,})
  {
    return   sharedPreferences!.get(key);
  }
  static dynamic deleteData({required String key,})
  {
    return   sharedPreferences!.remove(key);
  }
}