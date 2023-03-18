import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    Key? key,
  }) : super(key: key);

  static ValueNotifier<int> notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Navbar.notifier,
      builder: (context, value, _) {
        return BottomNavigationBar(
          //elevation: 8.0,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          currentIndex: notifier.value,
          onTap: (value) => notifier.value = value,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.home,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.shopping_cart),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.arrow_right_alt_sharp),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.person),
                ),
                label: ''),
          ],
        );
      },
    );
  }
}
