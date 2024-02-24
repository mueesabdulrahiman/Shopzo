import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shop_x/utils/config.dart';
import 'package:shop_x/presentation/account_page/account_page.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/order_page.dart/order_page.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:shop_x/utils/globals.dart' as globals;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pages = [
    const HomePage(),
    const CartPage(),
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
}

// onesignal in-app notification method

Future<void> initPlatformState() async {
//  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.initialize(Config.onesignalId);

  OneSignal.Notifications.requestPermission(true);

  OneSignal.Notifications.addClickListener((event) {
    event.notification.additionalData;
    globals.appNavigator!.currentState!
        .push(MaterialPageRoute(builder: (context) => const MainPage()));
  });
  // OneSignal.setNotificationOpenedHandler((openedResult) {
  //   openedResult.notification.additionalData;
  //   globals.appNavigator!.currentState!
  //       .push(MaterialPageRoute(builder: (context) => const MainPage()));
  // });

  // OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
  //   event.complete(event.notification);

  //   OneSignal.shared.getDeviceState().then((value) async {
  //     await ApiServices().addOneSignalPostId(value!.userId!);
  //   });
  // });
}
