import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_x/data_layer/data_providers/apiCalls.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';

class ApiRepositories {
  final ApiCalls apicalls;
  ApiRepositories({required this.apicalls});

  Future<bool?> registrationRepository(Customer model) async {
    bool? flag;
    try {
      final response = await apicalls.createCustomer(model);

      if (response.statusCode == 201 || response.statusCode == 200) {
        flag = true;
      }
    } on DioError catch (e) {
      log(e.message.toString());
      flag = false;
    } catch (e) {
      log(e.toString());
      flag = false;
    }
    return flag;
  }
}
