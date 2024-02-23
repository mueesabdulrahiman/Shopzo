import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/cart_page/widgets/cart_card_widget.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';

part 'cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  CartPageCubit() : super(CartPageInitial());
  bool view = false;

  void addToCart(BuildContext context,
      {required String name,
      required String salePrice,
      required String image,
      required int count,
      required int id}) {
    int existingCount = 0;

    final result = CartPage.cartProductsNotifier.value.indexWhere((product) {
      existingCount = product.count;
      return product.name == name;
    });

    if (result == -1) {
      final product = CartCardWidget(
        name: name,
        price: double.tryParse(salePrice) ?? 0.00,
        image: image,
        count: count,
        id: id.toString(),
      );
      CartPage.cartProductsNotifier.value.add(product);
      emit(CartPageAddProduct(
          addProduct: CartPage.cartProductsNotifier.value, newProduct: true));
      CartCounter.updatedCount = 1;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added to Cart'),
        duration: Duration(milliseconds: 1000),
      ));
    } else {
      CartPage.cartProductsNotifier.value.removeAt(result);
      CartPage.cartProductsNotifier.value.insert(
          result,
          CartCardWidget(
            name: name,
            price: double.tryParse(salePrice) ?? 0,
            image: image,
            count: existingCount + count,
            id: id.toString(),
          ));
      emit(CartPageAddProduct(
          addProduct: CartPage.cartProductsNotifier.value, newProduct: false));
      CartCounter.updatedCount = 1;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cart Product Updated'),
        duration: Duration(milliseconds: 800),
      ));
    }
  }
}
