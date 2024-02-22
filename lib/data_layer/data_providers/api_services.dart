import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_x/config.dart';
import 'package:shop_x/data_layer/models/categories.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';
import 'package:shop_x/data_layer/models/login_model.dart';
import 'package:shop_x/data_layer/models/order_details_model.dart';
import 'package:shop_x/data_layer/models/orders.dart';
import 'package:shop_x/data_layer/models/samples/sample.dart';
import 'package:shop_x/data_layer/models/user_details_model.dart';
import 'package:shop_x/utils/api_exception.dart';
import 'package:shop_x/utils/shared_preferences.dart';

//registration

class ApiServices {
  ApiException apiException = ApiException();
  Future<bool> createCustomer(Customer model, BuildContext context) async {
    late bool res;

    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));
    try {
      final response = await Dio(BaseOptions(headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
      })).post(Config.url + Config.customerUrl, data: model.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        res = true;
      } else {
        throw DioException(
            requestOptions:
                RequestOptions(path: Config.url + Config.customerUrl),
            response: response,
            type: DioExceptionType.connectionError);
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
      res = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return res;
  }

  //login

  Future<LoginResponseModel?> loginCustomer(
      String username, String password, BuildContext context) async {
    LoginResponseModel? model;

    final navigator = Navigator.of(context);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      final response = await Dio(BaseOptions(headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
      })).post(
        Config.tokenUrl,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        model = LoginResponseModel.fromJson(response.data);

        Config.userId = model.data!.id.toString();
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);

      navigator.pop();
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return model;
  }

  // lost password

  Future<bool> initiatePassswordReset(String email) async {
    bool passwordreset = false;
    try {
      final response = await Dio(BaseOptions(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        validateStatus: (status) => status! >= 200 && status < 400,
      )).post(Config.resetPasswordUrl, data: {
        'user_login': email,
      });
      if ([200, 302].contains(response.statusCode)) {
        passwordreset = true;
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return passwordreset;
  }

  // get products

  Future<List<Sample>> getProducts() async {
    List<Sample> products = [];

    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));
    final response = await Dio(BaseOptions(
      headers: {HttpHeaders.authorizationHeader: 'Basic $authToken'},
    )).get(
      Config.url + Config.productsUrl,
    );
    try {
      if (response.statusCode == 200) {
        final results = response.data
            .map((e) => Sample.fromJson(e as Map<String, dynamic>))
            .toList();
        for (Sample result in results) {
          if (result.status == 'publish') {
            products.add(result);
          }
        }
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return products;
  }

// get categories

  Future<List<Categories>> getCategories() async {
    List<Categories> categories = [];
    try {
      final response = await Dio().get(
          '${Config.url}${Config.categoriesUrl}?consumer_key=${Config.key}&consumer_secret=${Config.secret}',
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        categories =
            (response.data as List).map((e) => Categories.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return categories;
  }

// create order

  Future<bool> createOrder(OrderModel model) async {
    bool iscreated = false;

    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));
    try {
      final res = await Dio().post(Config.url + Config.orderUrl,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      if (res.statusCode == 200 || res.statusCode == 201) {
        iscreated = true;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return iscreated;
  }

  // get orders

  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> data = [];
    int? userId;

    try {
      final loginResponseModel = await SharedPrefService.getLoginDetails();
      if (loginResponseModel?.data != null) {
        userId = loginResponseModel!.data!.id;

        final response = await Dio().get(
            "${Config.url}${Config.orderUrl}?consumer_key=${Config.key}&consumer_secret=${Config.secret}",
            options: Options(
                headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
        if (response.statusCode == 200 || response.statusCode == 201) {
          final orders = (response.data as List)
              .map((e) => OrderModel.fromJson(e))
              .toList();
          for (final order in orders) {
            if (order.customerId == userId) {
              data.add(order);
            }
          }
        }
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
    }
    return data;
  }

// get order details

  Future<OrderDetailsModel> getOrderDetails(int orderId) async {
    OrderDetailsModel data = OrderDetailsModel();

    try {
      final response = await Dio().get(
          "${Config.url}${Config.orderUrl}/$orderId?consumer_key=${Config.key}&consumer_secret=${Config.secret}",
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        data = OrderDetailsModel.fromJson(response.data);
      
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
    }
    return data;
  }

// get customer details

  Future<CustomerDetailsModel?> getCustomerDetails() async {
    CustomerDetailsModel? model;
    int? userId;

    try {
      final loginResponseModel = await SharedPrefService.getLoginDetails();
      if (loginResponseModel?.data != null) {
        userId = loginResponseModel!.data!.id!;
        final res = await Dio().get(
            '${Config.url}${Config.customerUrl}/$userId?consumer_key=${Config.key}&consumer_secret=${Config.secret}');
        if (res.statusCode == 200 || res.statusCode == 201) {
          model = CustomerDetailsModel.fromJson(res.data);
        }
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return model;
  }

  // update customer details

  Future<CustomerDetailsModel?> updateCustomerDetails(
      CustomerDetailsModel customerModel) async {
    CustomerDetailsModel? updatedCustomer;
    int? userId;

    try {
      final loginResponseModel = await SharedPrefService.getLoginDetails();
      if (loginResponseModel?.data != null) {
        userId = loginResponseModel!.data!.id!;

        final res = await Dio().put(
            '${Config.url}${Config.customerUrl}/$userId?consumer_key=${Config.key}&consumer_secret=${Config.secret}',
            data: {
              'first_name': customerModel.firstName,
              'last_name': customerModel.lastName,
              'shipping': customerModel.shipping?.toJson(),
              'billing': customerModel.billing?.toJson()
            });
        if (res.statusCode == 200 || res.statusCode == 201) {
          updatedCustomer = CustomerDetailsModel.fromJson(res.data);
        }
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return updatedCustomer;
  }

  // delete customer

  Future<bool> deleteCustomer() async {
    try {
      String credentials =
          base64Encode(utf8.encode('${Config.key}:${Config.secret}'));

      final loginResponseModel = await SharedPrefService.getLoginDetails();
      if (loginResponseModel?.data != null) {
        final userId = loginResponseModel!.data!.id;
        final result = await Dio(BaseOptions(
          headers: {
            'Authorization': 'Basic $credentials',
            'Content-Type': 'application/json',
          },
        )).delete('${Config.url}${Config.customerUrl}/$userId?force=true');
        if (result.statusCode == 200 || result.statusCode == 201) {
          CustomerDetailsModel.fromJson(result.data);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
      if (kDebugMode) {
        print('Error:$e');
      }
      return false;
    }
  }

  // post customer playerid for notification details

  Future<bool> addOneSignalPostId(String playerId) async {
    bool flag = false;
    var authToken =
        base64.encode(utf8.encode("${Config.key}:${Config.secret}"));
    Map<String, String> requestHeaders = {
      HttpHeaders.authorizationHeader: "Basic $authToken",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    try {
      final response = await Dio()
          .post("${Config.url}${Config.customerUrl}/${Config.userId}",
              options: Options(
                headers: requestHeaders,
              ),
              data: {
            "meta_data": [
              {
                "key": "one_signal_id",
                "value": playerId,
              }
            ]
          });

      if (response.statusCode == 200 || response.statusCode == 201) {
        flag = true;
      }
    } on DioException catch (e) {
      apiException.getExceptionMessages(e);
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return flag;
  }
}
