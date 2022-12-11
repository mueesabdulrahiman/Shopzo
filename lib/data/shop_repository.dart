import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop_x/model/samples/sample.dart';

abstract class Apicalls {
  Future<List<Sample>?> getData();
}

class ShopzoDB implements Apicalls {
// singleton
  ShopzoDB._internal();
  static ShopzoDB instance = ShopzoDB._internal();
  ShopzoDB factory() {
    return instance;
  }

  @override
  Future<List<Sample>?> getData() async {
    try {
      final result = await Dio(BaseOptions(headers: {
        'Authorization':
            'Basic Y2tfZWE4NTRiYmYyNDEyYjNlYjQyMDdhOWQ2YmQxNjhkZGEzNWNiNzBiMQo6Y3NfMzg0ZjlkNmVlZGU5NWFmMDY4YmEyZDk4NDNjZTEyNzMyNTViMmRjOA=='
      })).get('https://shopzo.prokomers.com/wp-json/wc/v2/products/');
      if (result.statusCode == 200 || result.statusCode == 201) {
        // log(result.data.toString());
        // log(result.statusCode.toString());
        final data = result.data;
        // log(data.toString());
        final results = data
            .map((e) => Sample.fromJson(e as Map<String, dynamic>))
            .toList();
        List<Sample> samples = [];
        //var value = 'publish';
        for (Sample result in results) {
          if (result.status == 'publish') {
            samples.add(result);
          }
        }

        return samples;
      }
    } on DioError catch (e) {
      print(e.response!.data.toString());
    } catch (e) {
      //log(result.statusCode.toString());
      log('error');
    }

    return null;
  }
}
