extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'\S+@\S+\.\S+').hasMatch(this);
  }
}
