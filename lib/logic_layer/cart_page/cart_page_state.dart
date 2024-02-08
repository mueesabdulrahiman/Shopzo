part of 'cart_page_cubit.dart';

abstract class CartPageState extends Equatable {
  const CartPageState();

  @override
  List<Object> get props => [];
}

class CartPageInitial extends CartPageState {}


// ignore: must_be_immutable
class CartPageAddProduct extends CartPageState {
  final List<CartCardWidget> addProduct;
  bool newProduct;

  CartPageAddProduct({
    this.addProduct = const [],
    required this.newProduct,
  });
}

class ViewCartPage extends CartPageState {
  final bool flag;
  const ViewCartPage({required this.flag});
}

class Reverse extends CartPageState {
  final bool flag;

  const Reverse({required this.flag});
}
