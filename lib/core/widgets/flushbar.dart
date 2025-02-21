import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showError(BuildContext context, String message) {
  return Flushbar(
    message: message,
    icon: Icon(
      Icons.error,
      size: 28.0,
      color: Colors.red,
    ),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.red,
  ).show(context);
}

showSuccess(BuildContext context, String message) {
  return Flushbar(
    message: message,
    icon: Icon(
      Icons.check_circle,
      size: 28.0,
      color: Colors.green,
    ),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.green,
  ).show(context);
}
