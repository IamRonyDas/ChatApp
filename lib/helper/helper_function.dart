import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String profileImage = "";
  static String UserNumber = "USERNUMBERKEY";

  // ignore: non_constant_identifier_names
  static Future<bool> SaveUserLoggedInStatus(bool isUserloggedin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserloggedin);
  }

  static Future<bool> SaveUserEmail(String UserEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, UserEmail);
  }

  static Future<bool> SaveUserName(String UserName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, UserName);
  }

  static Future<bool> SaveUserPhone(String UserNum) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(UserNumber, UserNum);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future getUseremail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future getUserNumber() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(UserNumber);
  }
}
