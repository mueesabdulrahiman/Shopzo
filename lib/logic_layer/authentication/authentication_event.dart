part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class RegisteringUser extends AuthenticationEvent {
  final Customer customer;
  final BuildContext context;
  const RegisteringUser(this.context, {required this.customer});
}

class LoggingUser extends AuthenticationEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoggingUser(
    this.context, {
    required this.email,
    required this.password,
  });
}

class LogoutUser extends AuthenticationEvent {}

class PasswordVisibility extends AuthenticationEvent {}

class ResetPassword extends AuthenticationEvent {
  final String email;
  const ResetPassword({required this.email});
}

class LoadCustomerDetails extends AuthenticationEvent {}

class EditCustomerDetails extends AuthenticationEvent {
  final CustomerDetailsModel? updateCustomer;
  const EditCustomerDetails({required this.updateCustomer});
}

class DeleteCustomerDetails extends AuthenticationEvent {}
