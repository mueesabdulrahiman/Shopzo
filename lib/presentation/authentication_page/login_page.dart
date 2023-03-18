import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/logic_layer/loading/loading_cubit.dart';
import 'package:shop_x/presentation/authentication_page/signup_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/main_page.dart';
import 'package:shop_x/utils/email_validator.dart';
import 'package:shop_x/utils/progressHUD.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  ApiServices apiServices = ApiServices();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool inAsyncCall = false;

  @override
  void initState() {
    super.initState();
    //getkeyData();
  }

  // getkeyData() async {
  // final sharedPref = await SharedPreferences.getInstance();
  //final data = sharedPref.getString(SAVE_KEY_NAME);
  // if (data != null) {
  //   Navigator.of(_scaffoldKey.currentContext!)
  //       .pushReplacement(MaterialPageRoute(builder: (ctx) => MainPage()));
  // }
  //}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LogInAuthenticationLoaded) {
          // context.read<LoadingCubit>().loadingInactive();
          Navigator.push(_scaffoldKey.currentContext!,
              MaterialPageRoute(builder: (ctx) => MainPage()));
        } else if (state is AuthenticationError) {
          // context.read<LoadingCubit>().loadingInactive();
          ScaffoldMessenger.of(_scaffoldKey.currentContext!)
              .showSnackBar(const SnackBar(
            content: Text(
              'User credentials donot match',
            ),
            duration: Duration(milliseconds: 1000),
          ));
          log("currentState2: ${BlocProvider.of<LoadingCubit>(context).isloading}");
          //_emailController.clear();
          _passwordController.clear();
        }
        //else{
        //  context.read<LoadingCubit>().loadingInactive();
        // }
      },
      // else if (state is LogInAuthenticationLoaded &&
      //     state.loginModel == null) {
      //   context.read<LoadingCubit>().load(false);

      //   ScaffoldMessenger.of(_scaffoldKey.currentContext!)
      //       .showSnackBar(SnackBar(
      //     content: Text(
      //       state.error,
      //     ),
      //     duration: const Duration(milliseconds: 500),
      //   ));
      // }
      // else if (state is AuthenticationError) {
      //   context.read<LoadingCubit>().load(false);

      //   ScaffoldMessenger.of(_scaffoldKey.currentContext!)
      //       .showSnackBar(SnackBar(
      //     content: Text(
      //       state.error,
      //     ),
      //     duration: const Duration(milliseconds: 500),
      //   ));
      // }

      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: ProgressHUD(
            inAsyncCall: context.watch<AuthenticationBloc>().state is Loading?
                ? true
                : false,
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Enter Email',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is empty';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // BlocProvider.of<LoadingCubit>(context).loadingActive();

                          BlocProvider.of<AuthenticationBloc>(
                                  _scaffoldKey.currentContext!)
                              .add(LoggingUser(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                          //setKeyData();
                          //  log("currentState: ${BlocProvider.of<LoadingCubit>(context).isloading}");

                        }
                      },
                      child: const Text('Login '),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => const SignUp()));
                        },
                        child: const Text("Sign Up")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // setKeyData() async {
  //   final sharedPref = await SharedPreferences.getInstance();
  //   sharedPref.setString(SAVE_KEY_NAME, _emailController.text);
  // }
}
