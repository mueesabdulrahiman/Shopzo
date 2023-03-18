import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop_x/config.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';

class ApiCalls {
  Future<Response> createCustomer(Customer model) async {
    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));

    final response = await Dio(BaseOptions(
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
      },
    )).post(
      Config.url + Config.customerUrl,
      data: model.toJson(),
    );
    return response;
  }
}
