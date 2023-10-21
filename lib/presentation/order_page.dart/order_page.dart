import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/orders.dart';
import 'package:shop_x/presentation/order_page.dart/order_tracking_page.dart';
import 'package:shop_x/presentation/widgets/unAuth.dart';
import 'package:shop_x/utils/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    //getData().whenComplete(() => setState(() {}));
  }

  Future<List<OrderModel>> getData() async {
    ApiServices apiServices = ApiServices();
    final getOrders = await apiServices.getOrders();
    orders.clear();
    orders.addAll(getOrders);
    log("orders2 : $orders");
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: SharedPrefService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Order Page',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                ),
                body: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _listView(context, snapshot.data!);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              );
            } else {
              return const UnAuthWidget();
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

Widget _listView(BuildContext context, List<OrderModel> order) {
  return ListView.builder(
    itemCount: order.length,
    physics: const ScrollPhysics(),
    padding: const EdgeInsets.all(8),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: OrderPageCard(
            order: order[index],
          ));
    },
  );
}
