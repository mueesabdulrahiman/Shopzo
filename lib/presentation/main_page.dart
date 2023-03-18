import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/next_page.dart';
import 'package:shop_x/presentation/account_page/account_page.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/order_page.dart/order_details_page.dart';
import 'package:shop_x/presentation/order_page.dart/order_page.dart';
import 'package:shop_x/presentation/order_page.dart/order_tracking_page.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:shop_x/globals.dart' as globals;
import 'package:shop_x/verify_page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ApiServices apiServices = ApiServices();

  final _pages = [
    HomePage(),
     CartPage(),
    const OrderPage(),
    const AccountPage()
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Navbar.notifier,
        builder: (context, value, _) {
          return _pages[value];
        },
      ),
      bottomNavigationBar: const Navbar(),
    );
  }

// onesignal in-app notification method

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId('bb0605f2-bf8d-46f8-a1df-05b49feaf5e8');

    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      var data = openedResult.notification.additionalData;
      log(data.toString());
      globals.appNavigator!.currentState!
          .push(MaterialPageRoute(builder: (context) => MainPage()));
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      event.complete(event.notification);

      OneSignal.shared.getDeviceState().then((value) async {
        await apiServices.addOneSignalPostId(value!.userId!);
      });
    });
  }
}
