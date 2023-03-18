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
  LoginResponseModel? loginModel;
  LogInAuthenticationLoaded({this.loginModel});
}
class Loading extends AuthenticationState{
  
}

class AuthenticationError extends AuthenticationState {
  final String error;
  const AuthenticationError({required this.error});
}
