part of 'order_page_bloc.dart';

abstract class OrderPageEvent extends Equatable {
  const OrderPageEvent();

  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderPageEvent {
  final BuildContext context;
 const  CreateOrder(this.context);
}
