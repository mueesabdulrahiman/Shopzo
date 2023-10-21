import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shop_x/config.dart';
import 'package:shop_x/data_layer/models/categories.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';
import 'package:shop_x/data_layer/models/login_model.dart';
import 'package:shop_x/data_layer/models/order_details_model.dart';
import 'package:shop_x/data_layer/models/orders.dart';
import 'package:shop_x/data_layer/models/samples/category.dart';
import 'package:shop_x/data_layer/models/samples/sample.dart';
import 'package:shop_x/data_layer/models/userDetailsModel.dart';
import 'package:shop_x/utils/shared_preferences.dart';

//registration

class ApiServices {
  Future<bool> createCustomer(Customer model) async {
    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));

    late bool res;
    try {
      final response = await Dio(BaseOptions(
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
        },
      )).post(
        Config.url + Config.customerUrl,
        data: model.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        res = true;
        log(response.data.toString());
      }
    } on DioError catch (e) {
      log(e.message.toString());
      res = false;
    } catch (e) {
      log(e.toString());
      res = false;
    }
    return res;
  }

// get products

  Future<List<Sample>> getProducts() async {
    List<Sample> products = [];

    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));
    final res = await Dio(BaseOptions(
        headers: {HttpHeaders.authorizationHeader: 'Basic $authToken'})).get(
      Config.url + Config.productsUrl,
    );
    try {
      if (res.statusCode == 200 || res.statusCode == 201) {
        log(res.statusCode.toString());

        final results = res.data
            .map((e) => Sample.fromJson(e as Map<String, dynamic>))
            .toList();
        for (Sample result in results) {
          if (result.status == 'publish') {
            products.add(result);
          }
        }
      }
    } on DioError catch (e) {
      log(e.message.toString());
    } catch (e) {
      log(res.statusCode.toString());
    }

    return products;
  }

//login

  Future<LoginResponseModel?> loginCustomer(
      String username, String password) async {
    log(username.toString());
    log(password.toString());
    LoginResponseModel? model;
    var authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));
    try {
      final res = await Dio(BaseOptions(headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      })).post(
        Config.tokenUrl,
        data: {
          'username': username,
          'password': password,
        },
      );
      log(res.statusCode.toString());
      log(res.data.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        log(res.statusCode.toString());
        model = LoginResponseModel.fromJson(res.data);

        log(model.message ?? 'nil');
        Config.userId = model.data!.id.toString();
        log(Config.userId.toString());
      } else {
        log(res.toString());
      }
      log(res.data.toString());
    } on DioError catch (e) {
      log(e.message);
    }
    // catch (e) {
    //   log(e.toString());
    //   log('hi');
    // }
    return model;
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
    } on DioError catch (e) {
      log(e.response.toString());
    } catch (e) {
      log(e.toString());
    }
    return categories;
  }

// create order

  Future<bool> createOrder(OrderModel model) async {
    //log(model.toJson().toString());
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
    } on DioError catch (e) {
      log(e.error.toString());
    } catch (e) {
      log(e.toString());
    }
    return iscreated;
  }

  // get orders

  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> data = [];
    int? userId;

    try {
      final loginResponseModel = await SharedPrefService.loginDetails();
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
    } on DioError catch (e) {
      log(e.message.toString());
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
        log("details: $data");
        log("${data.lineItems}");
      }
    } on DioError catch (e) {
      log(e.message.toString());
    }
    return data;
  }

// get customer details

  Future<CustomerDetailsModel?> getCustomerDetails() async {
    CustomerDetailsModel? model;
    int? userId;
    //model!.id = int.parse(id);

    try {
      final loginResponseModel = await SharedPrefService.loginDetails();
      if (loginResponseModel?.data != null) {
        userId = loginResponseModel!.data!.id!;
        log("userId: $userId");
        final res = await Dio().get(
            '${Config.url}${Config.customerUrl}/$userId?consumer_key=${Config.key}&consumer_secret=${Config.secret}');
        if (res.statusCode == 200 || res.statusCode == 201) {
          model = CustomerDetailsModel.fromJson(res.data);
        }
      }
    } on DioError catch (e) {
      log(e.response.toString());
    } catch (e) {
      log(e.toString());
    }
    return model;
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
      log('**********************************');
      log(" statuscode :${response.statusCode}");
      log('**********************************');
      if (response.statusCode == 200 || response.statusCode == 201) {
        flag = true;
      }
    } on DioError catch (e) {
      log(e.message.toString());
    } catch (e) {
      log(e.toString());
    }

    return flag;
  }
}
