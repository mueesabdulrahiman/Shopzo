import 'package:flutter/material.dart';
import 'package:shop_x/presentation/account_page/account_page.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/notification_page/notification_page.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  final _pages = const [HomePage(), CartPage(), NotificationPage(), AccountPage()];

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
