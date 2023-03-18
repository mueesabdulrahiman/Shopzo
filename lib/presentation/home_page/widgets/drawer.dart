import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_x/presentation/authentication_page/login_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:shop_x/utils/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        children: [
          const DrawerHeader(child: Text('')),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navbar.notifier.value = 0;
            },
            child: const ListTile(
              title: Text('Home'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navbar.notifier.value = 1;
            },
            child: const ListTile(
              title: Text('Cart'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navbar.notifier.value = 2;
            },
            child: const ListTile(
              title: Text('Notifications'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navbar.notifier.value = 3;
            },
            child: const ListTile(
              title: Text('Account'),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // Navigator.pop(context);
              // Navbar.notifier.value = 3;

              //sharedPref.remove(SAVE_KEY_NAME);
              // final prefs = await SharedPreferences.getInstance();
              // prefs.remove('login_details');
             await  SharedPrefService.logout();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (ctx) => const SignIn()),
              //     (route) => false);
            },
            child: const ListTile(
              title: Text('Logout'),
            ),
          )
        ],
      ),
    );
  }
}
