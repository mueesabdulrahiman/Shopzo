import 'package:flutter/material.dart';
import 'package:shop_x/presentation/home_page/widgets/bottom_section.dart';
import 'package:shop_x/presentation/home_page/widgets/header_section.dart';
import 'package:shop_x/presentation/home_page/widgets/middle_section.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';

final screenSize = GlobalKey<ScaffoldState>();
final siz = MediaQuery.of(screenSize.currentContext!).size;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //drawer: Drawer(),
      key: screenSize,
      appBar: AppBar(
        iconTheme: ThemeData().iconTheme,
        backgroundColor: Colors.grey[50],
        elevation: 2,
        actions: [
          const Icon(
            Icons.search,
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          const Icon(
            Icons.shopping_basket_outlined,
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
        ],
      ),
      drawer: Drawer(
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
            )
          ],
        ),
      ),
      body: ListView(
          //shrinkWrap: true,
          //physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: size.width * 0.38,
              child: TopSection(size: size),
            ),
            // SizedBox(
            //   height: size.width * 0.01,
            // ),
            const Divider(
              thickness: 6.0,
            ),
            SizedBox(
              height: size.width * 0.02,
            ),
            const Text(
              'Categories',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            SizedBox(
              height: size.width * 0.18,
              child: MiddleSection(size: size),
            ),
            SizedBox(
              height: size.width * 0.02,
            ),
            const Divider(
              thickness: 6.0,
            ),
          const BottomSection(),
          ]),
    );
  }
}
