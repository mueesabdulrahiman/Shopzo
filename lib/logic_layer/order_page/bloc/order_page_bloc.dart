import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/orders.dart';
import 'package:shop_x/data_layer/models/userDetailsModel.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/cart_page/success_page.dart';

part 'order_page_event.dart';
part 'order_page_state.dart';

class OrderPageBloc extends Bloc<OrderPageEvent, OrderPageState> {
  final ApiServices apiServices;
  bool? orderCreated;
  CustomerDetailsModel? customerDetails;
  OrderPageBloc({required this.apiServices}) : super(OrderPageInitial()) {
    on<CreateOrder>((event, emit) async {
      emit(Loading());    
      OrderModel orderModel = OrderModel();
      Navigator.push(event.context,
          MaterialPageRoute(builder: (ctx) => const SuccessPage()));
      if (CartPage.cartProductsNotifier.value.isNotEmpty) {
        customerDetails = await apiServices.getCustomerDetails();
        log('cus: ${customerDetails!.shipping!.toJson()}');
        // emit(UserDetails(userDetails: customerDetails!));

        if (customerDetails?.shipping != null) {
          log('id: ${customerDetails?.id}');
          orderModel.shipping = Shipping1();
          orderModel.customerId = customerDetails?.id;

          orderModel.shipping!.address = customerDetails?.shipping!.address;
          orderModel.shipping!.city = customerDetails?.shipping!.city;
          orderModel.shipping!.company = customerDetails?.shipping!.company;
          orderModel.status = 'processing';
          orderModel.paymentMethod = 'Cash On Delivery';
        }
        if (orderModel.shipping != null) {
          orderModel.lineItems = <LineItems>[];

          for (final data in CartPage.cartProductsNotifier.value) {
            final item =
                LineItems(productId: int.parse(data.id), quantity: data.count);

            orderModel.lineItems!.add(item);
          }

          orderCreated = await apiServices.createOrder(orderModel);
          log("order result: $orderCreated");
          emit(OrderCreated(orders: orderCreated));

          CartPage.cartProductsNotifier.value.clear();

          // Navigator.push(
          //     _scaffoldKey
          //         .currentContext!,
          //     MaterialPageRoute(
          //         builder: (ctx) =>
          //             const SuccessPage()));
          // CartPage
          //     .cartProductsNotifier
          //     .value
          //     .clear();
        }
      }
    });
  }
}
