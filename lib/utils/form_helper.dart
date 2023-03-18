import 'package:flutter/material.dart';

class FormHelper {
  static Widget textInputField(
    BuildContext context,
    // String? initialValue,
    Function? onChanged, {
    required TextEditingController controller,
    required String labelName,
    bool isNumberInput = false,
    bool isTextArea = false,
    bool obscureText = false,
    Function? onValidate,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        //initialValue: initialValue ?? '',
        validator: onValidate != null
            ? (value) {
                return onValidate(value);
              }
            : null,
        decoration: fieldDecoration(
          context,
          labelName,
          '',
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ));
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helperText, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(6),
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
    );
  }

  static Widget onSubmit(
      {required Function onPress, required String buttonText}) {
    return ElevatedButton(onPressed: onPress(), child: Text(buttonText));
  }
}
