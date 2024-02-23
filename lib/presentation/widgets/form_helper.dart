import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FormHelper {
  static Widget textInputField({
    String? hintText,
    TextEditingController? controller,
    bool isNumberInput = false,
    bool isTextArea = false,
    bool obscureText = false,
    bool? readOnly,
    TextInputType textType = TextInputType.name,
    Function? onValidate,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextFormField(
        controller: controller,
        keyboardType: textType,
        obscureText: obscureText,
        readOnly: readOnly ?? false,
        validator: onValidate != null
            ? (value) {
                return onValidate(value);
              }
            : null,
        style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
        decoration: fieldDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ));
  }

  static InputDecoration fieldDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.sp))));
  }

  static Widget onSubmit(
      {required Function onPress, required String buttonText}) {
    return ElevatedButton(onPressed: onPress(), child: Text(buttonText));
  }

  static Widget fieldLabel(BuildContext context, String label) {
    return Text(
      label,
      style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 12.sp,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold),
    );
  }
}
