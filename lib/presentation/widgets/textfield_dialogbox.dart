import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:sizer/sizer.dart';

void textfieldDialogBox(BuildContext context) {
  String resetEmail = '';
  final formKey = GlobalKey<FormState>();

  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Reset Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold)),
          content: Form(
            key: formKey,
            child: TextFormField(
              onChanged: (value) => resetEmail = value,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.sp)))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is empty';
                } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                } else {
                  return null;
                }
              },
              style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
            ),
          ),
          contentPadding: EdgeInsets.all(8.sp),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<AuthenticationBloc>()
                        .add(ResetPassword(email: resetEmail));
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit',
                    style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp))),
          ],
        );
      });
}
