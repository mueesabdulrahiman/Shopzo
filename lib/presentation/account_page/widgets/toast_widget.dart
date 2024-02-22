import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

void showToastMessage(String message, Color? colour) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 10.sp,
      backgroundColor: colour ?? Colors.black,
      textColor: Colors.white);
}
