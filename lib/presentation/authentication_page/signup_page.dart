import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/customer_registeration.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/logic_layer/loading/loading_cubit.dart';
import 'package:shop_x/presentation/authentication_page/login_page.dart';
import 'package:shop_x/presentation/main_page.dart';
import 'package:shop_x/utils/api_exception.dart';
import 'package:shop_x/utils/form_helper.dart';
import 'package:shop_x/utils/progressHUD.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final signupScaffoldKey = GlobalKey<ScaffoldState>();

class _SignUpState extends State<SignUp> {
  late ApiServices apiServices;

  late Customer model;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _companyController = TextEditingController();
  final _cityController = TextEditingController(text:'Kasaragod');
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    apiServices = ApiServices();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _companyController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: signupScaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is RegistrationAuthenticationLoaded) {
            final result = state.result;

            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Registration Success'),
                duration: Duration(seconds: 2),
              ));

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignIn()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(ApiException.exceptionMsg),
                duration: const Duration(seconds: 2),
              ));
            }
          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(ApiException.normalExceptionMsg),
              duration: const Duration(seconds: 2),
            ));
          }
        },
        builder: (context, state) => Stack(
          children: [
            SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormHelper.textInputField(
                          controller: _emailController,
                          hintText: 'Enter Email',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is empty';
                            } else if (!RegExp(r'\S+@\S+\.\S+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                          },
                          textType: TextInputType.emailAddress),
                      SizedBox(
                        height: 1.h,
                      ),
                      FormHelper.textInputField(
                        obscureText: !context
                            .watch<AuthenticationBloc>()
                            .passwordVisible,
                        controller: _passwordController,
                        hintText: 'Enter Password',
                        suffixIcon: GestureDetector(
                            onTap: () => BlocProvider.of<AuthenticationBloc>(
                                    context,
                                    listen: false)
                                .add(PasswordVisibility()),
                            child: BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                bool currentState =
                                    state is AuthenticationPasswordVisibility &&
                                        state.passwordVisible == true;

                                return currentState
                                    ? Icon(
                                        Icons.visibility,
                                        size: 18.sp,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        size: 18.sp,
                                      );
                              },
                            )),
                        onValidate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Password is empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      FormHelper.textInputField(
                        obscureText: !context
                            .watch<AuthenticationBloc>()
                            .passwordVisible,
                        controller: _confirmPasswordController,
                        hintText: 'Enter Confirm Password ',
                        suffixIcon: GestureDetector(
                            onTap: () => BlocProvider.of<AuthenticationBloc>(
                                    context,
                                    listen: false)
                                .add(PasswordVisibility()),
                            child: BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                bool currentState =
                                    state is AuthenticationPasswordVisibility &&
                                        state.passwordVisible == true;

                                return currentState
                                    ? Icon(
                                        Icons.visibility,
                                        size: 18.sp,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        size: 18.sp,
                                      );
                              },
                            )),
                        onValidate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Confirm Password is empty';
                          } else if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return 'Password mismatch';
                          }
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormHelper.textInputField(
                              controller: _fnameController,
                              hintText: 'Enter First Name ',
                              onValidate: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'First Name is empty';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: FormHelper.textInputField(
                              controller: _lnameController,
                              hintText: 'Enter Last Name ',
                              onValidate: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Last Name is empty';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      FormHelper.textInputField(
                        controller: _companyController,
                        hintText: 'Enter Company ',
                        onValidate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Company Name is empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      FormHelper.textInputField(
                        controller: _cityController,
                        readOnly: true,
                        hintText: 'Enter City ',
                        onValidate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'City Name is empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      FormHelper.textInputField(
                        controller: _addressController,
                        hintText: 'Enter Address ',
                        onValidate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Address  is empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      FormHelper.textInputField(
                        controller: _phoneController,
                        hintText: 'Enter Phone Number',
                        onValidate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Phone number is empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            log(_emailController.text);
                            final customer = Customer(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              _fnameController.text.trim(),
                              _lnameController.text.trim(),
                              Shipping(
                                city: _cityController.text.trim(),
                                address: _addressController.text.trim(),
                                company: _companyController.text.trim(),
                              ),
                              Billing(
                                city: _cityController.text.trim(),
                                address: _addressController.text.trim(),
                                company: _companyController.text.trim(),
                                phone: _phoneController.text.trim(),
                              ),
                            );

                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  RegisteringUser(context, customer: customer));
                            }

                            // final value =
                            //  context.watch<AuthenticationBloc>().result;
                            // BlocProvider.of<AuthenticationBloc>(context,
                            //         listen: false)
                            //     .result;

                            // if (value) {
                            //  context.read<LoadingCubit>().loadingInactive();

                            // Navigator.push(
                            //     _scaffoldKey.currentContext!,
                            //     MaterialPageRoute(
                            //       builder: (context) => const SignIn(),
                            //     ));
                            //   Navigator.pushAndRemoveUntil(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (_) => const SignIn()),
                            //       (route) => false);
                            // } else {
                            //  context.read<LoadingCubit>().loadingInactive();

                            // ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                            //     .showSnackBar(const SnackBar(
                            //   content: Text(
                            //     'Something went wrong',
                            //   ),
                            //   duration: Duration(seconds: 2),
                            // ));
                            //   }
                            // }
                          },
                          child: Text('Sign Up',
                              style: TextStyle(
                                  fontFamily: 'Lato', fontSize: 12.sp))),
                      Align(
                        alignment: Alignment.center,
                        child: Text('or',
                            style:
                                TextStyle(fontFamily: 'Lato', fontSize: 10.sp)),
                      ),
                      TextButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                  const BorderSide(color: Colors.green))),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => const SignIn()));
                          },
                          child: Text("Sign In",
                              style: TextStyle(
                                  fontFamily: 'Lato', fontSize: 12.sp))),
                    ],
                  ),
                ),
              ),
            )),
            state is Loading
                ? const Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
