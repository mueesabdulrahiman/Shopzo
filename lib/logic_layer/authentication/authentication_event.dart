part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class RegisteringUser extends AuthenticationEvent {
  final Customer customer;

  const RegisteringUser({required this.customer});
}

class LoggingUser extends AuthenticationEvent {
  final String email;
  final String password;

  const LoggingUser({
    required this.email,
    required this.password,
  });
}

class LogoutUser extends AuthenticationEvent {}
