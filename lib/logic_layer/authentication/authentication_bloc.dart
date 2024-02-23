import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';
import 'package:shop_x/data_layer/models/login_model.dart';
import 'package:shop_x/data_layer/models/user_details_model.dart';
import 'package:shop_x/utils/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiServices apiServices;
  bool passwordVisible = false;
  bool readOnly = true;
  CustomerDetailsModel? customerDetails;

  AuthenticationBloc({required this.apiServices})
      : super(AuthenticationInitial()) {
    on<RegisteringUser>((event, emit) async {
      try {
        emit(Loading());

        final result =
            await apiServices.createCustomer(event.customer, event.context);
        if (result == true) {
          emit(RegistrationAuthenticationLoaded(result: result));
        } else {
          emit(const RegistrationAuthenticationLoaded(result: false));
        }
      } catch (e) {
        emit(const AuthenticationError());
      }
    });

    on<LoggingUser>((event, emit) async {
      try {
        emit(Loading());
        final loginModel = await apiServices.loginCustomer(
            event.email, event.password, event.context);

        if (loginModel != null) {
          emit(LogInAuthenticationLoaded(loginModel: loginModel));
          await SharedPrefService.setLoginDetails(loginModel);
        } else {
          emit(const AuthenticationError());
        }
      } catch (e) {
        emit(const AuthenticationError());
      }
    });

    on<PasswordVisibility>((event, emit) {
      emit(AuthenticationInitial());
      passwordVisible = !passwordVisible;

      emit(AuthenticationPasswordVisibility(passwordVisible: passwordVisible));
    });

    on<ResetPassword>((event, emit) async {
      try {
        final result = await apiServices.initiatePassswordReset(event.email);
        if (result) {
          emit(AuthenticationPasswordChanged());
        }
      } catch (e) {
        emit(const AuthenticationError());
      }
    });

    on<LoadCustomerDetails>((event, emit) async {
      try {
        emit(Loading());
        customerDetails = await apiServices.getCustomerDetails();
        if (customerDetails != null) {
          emit(AuthenticatedCustomerDetails(customerModel: customerDetails!));
        }
      } catch (e) {
        emit(const AuthenticationError());
      }
    });

    on<EditCustomerDetails>((event, emit) async {
      try {
        emit(Loading());
        if (readOnly) {
          if (customerDetails != null) {
            emit(AuthenticatedCustomerDetails(customerModel: customerDetails!));
            readOnly = false;
          }
        } else {
          final updatedCustomer =
              await apiServices.updateCustomerDetails(event.updateCustomer!);
          if (updatedCustomer != null) {
            customerDetails = updatedCustomer;
            emit(AuthenticatedCustomerDetails(customerModel: customerDetails!));
            readOnly = true;
          }
        }
      } catch (e) {
        emit(const AuthenticationError());
      }
    });

    on<DeleteCustomerDetails>((event, emit) async {
      try {
        final result = await apiServices.deleteCustomer();
        if (result) {
          emit(DeleteCustomer(result: result));
        } else {
          emit(DeleteCustomer(result: result));
        }
      } catch (e) {
        emit(const DeleteCustomer(result: false));
      }
    });
  }
}
