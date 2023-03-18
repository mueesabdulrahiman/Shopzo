part of 'order_page_bloc.dart';

abstract class OrderPageState extends Equatable {
  const OrderPageState();

  @override
  List<Object> get props => [];
}

class OrderPageInitial extends OrderPageState {}

class Loading extends OrderPageState {}

class OrderCreated extends OrderPageState {
  bool? orders;
  OrderCreated({required this.orders});
}

class UserDetails extends OrderPageState {
  CustomerDetailsModel userDetails;
  UserDetails({required this.userDetails});
}


