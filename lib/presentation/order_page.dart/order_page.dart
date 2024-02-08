import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/orders.dart';
import 'package:shop_x/presentation/order_page.dart/widgets/orderCard.dart';
import 'package:shop_x/presentation/widgets/unAuth.dart';
import 'package:shop_x/utils/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<OrderModel> orders = [];
  ApiServices apiServices = ApiServices();

  Future<List<OrderModel>> getData() async {
    ApiServices apiServices = ApiServices();
    final getOrders = await apiServices.getOrders();
    orders.clear();
    orders.addAll(getOrders);
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: SharedPrefService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  foregroundColor:
                      Theme.of(context).appBarTheme.foregroundColor,
                  elevation: 0,
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'),
                  ),
                  centerTitle: true,
                ),
                body: FutureBuilder<List<OrderModel>>(
                  future: apiServices.getOrders(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _listView(context, snapshot.data!);
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Orders yet'));
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
    padding: EdgeInsets.all(8.sp),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Card(
          color: Theme.of(context).cardColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp)),
          child: OrderPageCard(
            order: order[index],
          ));
    },
  );
}
