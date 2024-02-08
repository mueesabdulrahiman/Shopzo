import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:shop_x/utils/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void showDialogBox(BuildContext context, void Function()? method,
    {required String title, required String description}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp)),
          content: Text(description,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp)),
          contentPadding: EdgeInsets.all(8.sp),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await SharedPrefService.logout();
                  Navbar.notifier.value = 0;
                  Navbar.notifier.notifyListeners();
                  final d = await SharedPrefService.isLoggedIn();
                  method;
                  log('shared2:$d');
                },
                child: Text('Yes',
                    style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp))),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('No',
                    style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp)))
          ],
        );
      });
}
