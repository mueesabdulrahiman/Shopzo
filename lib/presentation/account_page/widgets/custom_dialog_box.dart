import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void showDialogBox(BuildContext context, void Function() onPressed,
    {required String title, required String description}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold)),
          content: Text(description,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp)),
          contentPadding: EdgeInsets.all(8.sp),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
                onPressed: onPressed,
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
