      import 'dart:developer';

      import 'package:flutter/material.dart';
      import 'package:flutter_bloc/flutter_bloc.dart';
      import 'package:shop_x/data_layer/data_providers/api_services.dart';
      import 'package:shop_x/data_layer/models/customer_registeration.dart';
      import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
      import 'package:shop_x/logic_layer/loading/loading_cubit.dart';
      import 'package:shop_x/presentation/authentication_page/login_page.dart';
      import 'package:shop_x/utils/form_helper.dart';
      import 'package:shop_x/utils/progressHUD.dart';

      class SignUp extends StatefulWidget {
        const SignUp({super.key});

        @override
        State<SignUp> createState() => _SignUpState();
      }

      class _SignUpState extends State<SignUp> {
        late ApiServices apiServices;
        late Customer model;
        final _scaffoldKey = GlobalKey<ScaffoldState>();
        final _formKey = GlobalKey<FormState>();
        final _emailController = TextEditingController();
        final _passwordController = TextEditingController();
        final _fnameController = TextEditingController();
        final _lnameController = TextEditingController();
        final _companyController = TextEditingController();
        final _cityController = TextEditingController();
        final _addressController = TextEditingController();
        final _phoneController = TextEditingController();
        bool inAsyncCall = false;

        @override
        void initState() {
          apiServices = ApiServices();
          super.initState();
        }

        @override
        void dispose() {
          _emailController.dispose();
          _passwordController.dispose();
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
            key: _scaffoldKey,
            body: SafeArea(
                child: ProgressHUD(
              inAsyncCall: context.watch<LoadingCubit>().state is LoadingInActive ? true : false,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormHelper.textInputField(
                            context,
                            () {},
                            controller: _emailController,
                            labelName: 'Enter Email ',
                            onValidate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Email Address is empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          FormHelper.textInputField(
                            context,
                            () {},
                            controller: _passwordController,
                            labelName: 'Enter Password ',
                            onValidate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Password is empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FormHelper.textInputField(
                                  context,
                                  () {},
                                  controller: _fnameController,
                                  labelName: 'Enter First Name ',
                                  onValidate: (value) {
                                    if (value == null || value.toString().isEmpty) {
                                      return 'First Name is empty';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: FormHelper.textInputField(
                                  context,
                                  () {},
                                  controller: _lnameController,
                                  labelName: 'Enter Last Name ',
                                  onValidate: (value) {
                                    if (value == null || value.toString().isEmpty) {
                                      return 'Last Name is empty';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          FormHelper.textInputField(
                            context,
                            () {},
                            controller: _companyController,
                            labelName: 'Enter Company ',
                            onValidate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Company Name is empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          FormHelper.textInputField(
                            context,
                            () {},
                            controller: _cityController,
                            labelName: 'Enter City ',
                            onValidate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'City Name is empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          FormHelper.textInputField(
                            context,
                            () {},
                            controller: _addressController,
                            labelName: 'Enter Address ',
                            onValidate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Address  is empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          FormHelper.textInputField(
                            context,
                            () {},
                            controller: _phoneController,
                            labelName: 'Enter Phone Number',
                            onValidate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Phone number is empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final customer = Customer(
                                  _emailController.text,
                                  _passwordController.text,
                                  _fnameController.text,
                                  _lnameController.text,
                                  Shipping(
                                    city: _cityController.text,
                                    address: _addressController.text,
                                    company: _companyController.text,
                                  ),
                                  Billing(
                                    city: _cityController.text,
                                    address: _addressController.text,
                                    company: _companyController.text,
                                    phone: _phoneController.text,
                                  ),
                                );

                                if (_formKey.currentState!.validate()) {
                                  context.read<LoadingCubit>().loadingActive();

                                  BlocProvider.of<AuthenticationBloc>(
                                          _scaffoldKey.currentContext!)
                                      .add(RegisteringUser(customer: customer));

                                  final value =
                                      context.watch<AuthenticationBloc>().result;

                                  if (value) {
                                    context.read<LoadingCubit>().loadingInactive();

                                    Navigator.pushReplacement(
                                        _scaffoldKey.currentContext!,
                                        MaterialPageRoute(
                                          builder: (context) => const SignIn(),
                                        ));
                                  } else {
                                    context.read<LoadingCubit>().loadingInactive();

                                    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        'Something went wrong',
                                      ),
                                      duration: Duration(milliseconds: 500),
                                    ));
                                  }
                                }
                              },
                              child: const Text('Register')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => const SignIn()));
                              },
                              child: const Text("Sign In")),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
          );
        }
      }
