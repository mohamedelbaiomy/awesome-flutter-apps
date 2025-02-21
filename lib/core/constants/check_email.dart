extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^[a-zA-Z0-9\_\.\-]+[a-zA-Z0-9]*[@][a-zA-Z0-9]{2,}[\.][a-zA-Z]{2,3}$')
        .hasMatch(this);
  }
}
