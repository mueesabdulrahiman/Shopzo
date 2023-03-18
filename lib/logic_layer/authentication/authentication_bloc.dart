import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';
import 'package:shop_x/data_layer/models/login_model.dart';
import 'package:shop_x/utils/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiServices apiServices;
  late bool result;
  late bool loading;
  LoginResponseModel? loginModel;

  AuthenticationBloc({required this.apiServices})
      : super(AuthenticationInitial()) {
    on<RegisteringUser>((event, emit) async {
      // emit(AuthenticationLoading());
      try {
        result = await apiServices.createCustomer(event.customer);
        emit(RegistrationAuthenticationLoaded(result: result));

        // if (_formKey.currentState!.validate()) {}
      } catch (e) {
        emit(AuthenticationError(error: e.toString()));
      }
    });

    on<LoggingUser>((event, emit) async {
      // emit(const StartLoading());
      emit(Loading());
      loginModel = await apiServices.loginCustomer(event.email, event.password);

      if (loginModel != null) {
        await SharedPrefService.setLoginDetails(loginModel);
        emit(LogInAuthenticationLoaded(loginModel: loginModel));
      } else {
        log("loginModel: $loginModel");
        emit(const AuthenticationError(error: 'error'));
      }
    });
  }
}
