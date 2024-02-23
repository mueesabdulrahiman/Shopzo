import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
            height: 70.sp,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Icon(
              Icons.lock,
              size: 30.sp,
              color: Colors.white,
            )),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            'You must Sign-In to access this section',
            style: TextStyle(
                color: Colors.green, fontSize: 15.sp, fontFamily: 'Lato'),
          ),
          SizedBox(
            height: 1.h,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.green,
              ),
              minimumSize: MaterialStateProperty.all(Size(25.w, 5.h)),
            ),
            child: Text(
              'Login',
              style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp),
            ),
            onPressed: () {
              
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SignIn()));
            },
          ),
        ],
      ),
    );
  }
}
