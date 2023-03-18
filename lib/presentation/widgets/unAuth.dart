import 'package:flutter/material.dart';
import 'package:shop_x/presentation/authentication_page/login_page.dart';

class UnAuthWidget extends StatelessWidget {
  const UnAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Center(
                child: Icon(
              Icons.lock,
              size: 50.0,
              color: Colors.white,
            )),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'You must Sign-In to access this section',
            style: TextStyle(color: Colors.green, fontSize: 20.0),
          ),
          const SizedBox(
            height: 5.0,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.green,
              ),
              minimumSize: MaterialStateProperty.all(const Size(100, 40)),
            ),
            child: const Text('Login'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const SignIn()),
              );
            },
          ),
        ],
      ),
    );
  }
}
