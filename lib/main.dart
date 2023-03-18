import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data/shop_repository.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/logic_layer/loading/loading_cubit.dart';
import 'package:shop_x/logic_layer/order_page/bloc/order_page_bloc.dart';
import 'package:shop_x/presentation/authentication_page/login_page.dart';
import 'package:shop_x/presentation/authentication_page/signup_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/main_page.dart';

import 'messaging.dart';
import 'globals.dart' as globals;

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //  SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.immersiveSticky,
  // );
  // await SystemChannels.platform.invokeMethod<void>(
  //   'SystemChrome.restoreSystemUIOverlays',
  // );
  globals.appNavigator = GlobalKey<NavigatorState>();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: ((context) => AuthenticationBloc(apiServices: ApiServices())),
        ),
        BlocProvider<LoadingCubit>(
          create: (context) => LoadingCubit(),
        ),
        BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(apiServices: ApiServices()),
        ),
        BlocProvider<CartPageCubit>(create: (context) => CartPageCubit()),
        BlocProvider<OrderPageBloc>(
      create: (context) => OrderPageBloc(apiServices: ApiServices())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: globals.appNavigator,
        home: MainPage(),
      ),
    );
  }
}
