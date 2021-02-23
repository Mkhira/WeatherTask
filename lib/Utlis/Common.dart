

import 'package:shared_preferences/shared_preferences.dart';

class Common{
  static final String curentUserToken = "curentUserToken";
  static final String isLogin = "no";
  static final String name = "name";
  static final String password = "password";

  static getIsLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool login = _prefs.getBool(Common.isLogin) ?? false ;
    return login;
  }

  static getName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userName = _prefs.getString(Common.name) ?? '';

    return userName;
  }

  static getPassword() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String password = _prefs.getString(Common.password) ?? '';

    return password;
  }

  static getHeaders() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String TOKEN = _prefs.getString(Common.curentUserToken) ?? '';
    var tokenData = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':TOKEN,
      'lang': 'ar'
    };
    return tokenData;
  }

}