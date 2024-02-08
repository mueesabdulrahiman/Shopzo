import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_x/config.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/globals.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/logic_layer/loading/loading_cubit.dart';
import 'package:shop_x/presentation/authentication_page/signup_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/main_page.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:shop_x/utils/api_exception.dart';
import 'package:shop_x/utils/email_validator.dart';
import 'package:shop_x/utils/progressHUD.dart';
import 'package:shop_x/utils/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  ApiServices apiServices = ApiServices();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool inAsyncCall = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  final _url = Uri.parse(Config.resetPasswordUrl);
  _urlLaunch() async {
    final url = Uri.parse(Config.resetPasswordUrl);
    // Uri(scheme: 'https', host:  );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
        if (state is LogInAuthenticationLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login Success'),
            duration: Duration(seconds: 2),
          ));

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => MainPage()), (route) => false);
        } else if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              ApiException.exceptionMsg,
              style: TextStyle(
                  fontFamily: 'Lato', fontSize: 10.sp, color: Colors.white),
            ),
            duration: const Duration(seconds: 3),
          ));

          _passwordController.clear();
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15.sp),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Enter Email',
                            hintStyle:
                                TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.sp)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is empty';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !context
                            .watch<AuthenticationBloc>()
                            .passwordVisible,
                        decoration: InputDecoration(
                            hintText: 'Enter Password',
                            hintStyle:
                                TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.sp))),
                            suffixIcon: GestureDetector(
                              onTap: () => BlocProvider.of<AuthenticationBloc>(
                                      context,
                                      listen: false)
                                  .add(PasswordVisibility()),
                              child: BlocBuilder<AuthenticationBloc,
                                  AuthenticationState>(
                                builder: (context, state) {
                                  bool currentState = state
                                          is AuthenticationPasswordVisibility &&
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
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is empty';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            launchUrl(_url, mode: LaunchMode.inAppWebView);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LoggingUser(
                              context,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                          }
                        },
                        child: Text('Sign In',
                            style:
                                TextStyle(fontFamily: 'Lato', fontSize: 12.sp)),
                      ),
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
                                    builder: (ctx) => const SignUp()));
                          },
                          child: Text("Sign Up",
                              style: TextStyle(
                                  fontFamily: 'Lato', fontSize: 12.sp))),
                    ],
                  ),
                ),
              ),
            ),
            // state is Loading
            //     ? Container(
            //         height: double.infinity,
            //         width: double.infinity,
            //         color: Colors.grey.shade50,
            //         child: const Center(child: CircularProgressIndicator()),
            //       )
            //     : const SizedBox()
          ],
        );
      }),
    );
  }
}

 


// ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   backgroundColor: Colors.red,
//   content: Text(
//     ApiException.exceptionMsg,
//     style: TextStyle(
//         fontFamily: 'Lato', fontSize: 10.sp, color: Colors.white),
//   ),
//   duration: const Duration(seconds: 3),
// ));
