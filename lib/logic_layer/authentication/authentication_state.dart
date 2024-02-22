part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class RegistrationAuthenticationLoaded extends AuthenticationState {
  final bool result;
  const RegistrationAuthenticationLoaded({required this.result});
}

class LogInAuthenticationLoaded extends AuthenticationState {
  final LoginResponseModel loginModel;
  const LogInAuthenticationLoaded({required this.loginModel});
}

class Loading extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError();
}

// ignore: must_be_immutable
class AuthenticationPasswordVisibility extends AuthenticationState {
  bool passwordVisible;
  AuthenticationPasswordVisibility({this.passwordVisible = false});
}

class AuthenticationPasswordChanged extends AuthenticationState {
  
}

class AuthenticatedCustomerDetails extends AuthenticationState {
  final CustomerDetailsModel customerModel;
  const AuthenticatedCustomerDetails({required this.customerModel});
}

class EditCustomerAuthData extends AuthenticationState {
  final bool didEdit;
  const EditCustomerAuthData({required this.didEdit});
}

class DeleteCustomer extends AuthenticationState {
  final bool result;
  const DeleteCustomer({required this.result});
}
