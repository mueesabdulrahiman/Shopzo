// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/presentation/cart_page/widgets/cart_card_widget.dart';
import 'package:shop_x/presentation/cart_page/widgets/checkout_comtainer.dart';
import 'package:shop_x/presentation/widgets/unAuth.dart';
import 'package:shop_x/utils/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static ValueNotifier<List<CartCardWidget>> cartProductsNotifier =
      ValueNotifier([]);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ApiServices apiServices = ApiServices();

  num calculateTotalPrice() {
    num totalPrice = 0;
    for (final cartProduct in CartPage.cartProductsNotifier.value) {
      totalPrice += cartProduct.price * cartProduct.count;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    calculateTotalPrice();

    return FutureBuilder<bool>(
        future: SharedPrefService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return _buildCartItems(context);
            } else {
              return const UnAuthWidget();
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildCartItems(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'My Cart',
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CartPage.cartProductsNotifier.value.isNotEmpty
            ? _buildCartListView(context)
            : _buildCartEmptyListView(),
      ),
    );
  }

  Center _buildCartEmptyListView() {
    return Center(
      child: Text(
        'Cart is empty',
        style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 10.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
    );
  }

  ValueListenableBuilder<List<CartCardWidget>> _buildCartListView(
      BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CartPage.cartProductsNotifier,
      builder: (ctx, value, _) {
        return Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
              itemBuilder: (ctx, index) {
                return value[index];
              },
              itemCount: value.length,
              separatorBuilder: (context, index) => _seperator(),
            ),
            CartPage.cartProductsNotifier.value.isEmpty
                ? _buildCartEmptyListView()
                : Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border(
                              top: BorderSide(
                                  width: 1,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor))),
                      height: 60,
                      child: buildCheckoutContainer(
                          context, calculateTotalPrice()),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

Widget _seperator() {
  return Column(
    children: [
      SizedBox(
        height: 1.h,
      ),
      Divider(
        thickness: 1.sp,
      ),
      SizedBox(
        height: 1.h,
      ),
    ],
  );
}
