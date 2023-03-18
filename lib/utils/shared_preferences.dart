import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_x/data_layer/models/login_model.dart';

class SharedPrefService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_details') != null ? true : false;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_details') != null
        ? LoginResponseModel.fromJson(
            jsonDecode(prefs.getString('login_details')!))
        : null;
  }

  static Future<void>setLoginDetails(LoginResponseModel? loginDetails) async {
    final prefs = await SharedPreferences.getInstance();
     prefs.setString('login_details', jsonEncode(loginDetails?.toJson()));
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
     //await setLoginDetails(null);
    prefs.remove('login_details');
  }
}
