import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/globals.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/logic_layer/loading/loading_cubit.dart';
import 'package:shop_x/logic_layer/order_page/bloc/order_page_bloc.dart';
import 'package:shop_x/logic_layer/theme/theme_bloc.dart';
import 'package:shop_x/presentation/flash_page.dart';
import 'package:shop_x/presentation/main_page.dart';
import 'package:shop_x/utils/theme.dart';
import 'package:sizer/sizer.dart';
import 'globals.dart' as globals;



Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  globals.appNavigator = GlobalKey<NavigatorState>();

   HttpOverrides.global = MyHttpOverrides();


  runApp(
    DevicePreview(enabled: false, builder: (context) => const MyApp()),
  );

  

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
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
      child: Sizer(builder: (context, orientation, deviceType) {
        return BlocBuilder<ThemeBloc, ThemeMode>(
          builder: (context, state) {
            return MaterialApp(
              key: snackbarKey,
              debugShowCheckedModeBanner: false,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              navigatorKey: globals.appNavigator,
              theme: lightTheme,
              themeMode: state,
              darkTheme: darkTheme,
              home: const MainPage(),
            );
          },
        );
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

