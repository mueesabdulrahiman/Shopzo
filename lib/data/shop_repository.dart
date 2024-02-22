import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shop_x/data_layer/models/samples/sample.dart';

abstract class Apicalls {
  Future<List<Sample>?> getData();
  Future createData();
  Future<void> deleteData(int id);
  Future<bool> createOrder();
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
    List<Sample> samples = [];

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
        //var value = 'publish';
        for (Sample result in results) {
          if (result.status == 'publish') {
            samples.add(result);
          }
        }
      }
    } on DioError catch (e) {
      print(e.error);
    } catch (e) {
      //log(result.statusCode.toString());
      log('error');
    }

    return samples;
  }

  @override
  Future createData() async {
    try {
      final result = await Dio(BaseOptions(headers: {
        'Authorization':
            'Basic Y2tfZWE4NTRiYmYyNDEyYjNlYjQyMDdhOWQ2YmQxNjhkZGEzNWNiNzBiMQo6Y3NfMzg0ZjlkNmVlZGU5NWFmMDY4YmEyZDk4NDNjZTEyNzMyNTViMmRjOA=='
      })).post('https://shopzo.prokomers.com/wp-json/wc/v2/products/',
          data: <String, dynamic>{
            'name': 'Mr.white',
            'status': 'publish',
            'price': '269',
            'total_sales': '5',
          });

      // if (result.statusCode == 200 || result.statusCode == 201) {

      // }
      log(result.statusCode.toString());
      log(result.data.toString());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteData(int id) async {
    await Dio(BaseOptions(headers: {
      'Authorization':
          'Basic Y2tfZWE4NTRiYmYyNDEyYjNlYjQyMDdhOWQ2YmQxNjhkZGEzNWNiNzBiMQo6Y3NfMzg0ZjlkNmVlZGU5NWFmMDY4YmEyZDk4NDNjZTEyNzMyNTViMmRjOA=='
    })).delete('https://shopzo.prokomers.com/wp-json/wc/v2/products/$id');
    await getData();
  }

  Future<bool> createOrder() async {
    return true;
  }
}
