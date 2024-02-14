import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';
import 'package:shop_x/data_layer/models/login_model.dart';

class SharedPrefService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_details') != null ? true : false;
  }

  static Future<LoginResponseModel?> getLoginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    log('getString:${prefs.getString('login_details')}');
    return prefs.getString('login_details') != null
        ? LoginResponseModel.fromJson(
            jsonDecode(prefs.getString('login_details')!))
        : null;
  }

  static Future<void> setLoginDetails(LoginResponseModel loginDetails) async {
    final prefs = await SharedPreferences.getInstance();
    // if(loginDetails is LoginResponseModel){
    await prefs.setString('login_details', jsonEncode(loginDetails.toJson()));
    // }else if(loginDetails is Customer) {
    //    await prefs.setString('login_details', jsonEncode(loginDetails.toJson()));
    // }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    //await setLoginDetails(null);
    await prefs.remove('login_details');
    // prefs.clear();
  }
}
