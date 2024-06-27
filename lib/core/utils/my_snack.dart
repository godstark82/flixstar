import 'package:flutter/material.dart';

class MySnackBar {
  static void showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade900,
    ));
  }

  static void showgreenSnackBar(BuildContext context,
      {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));
  }

  static void showredSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }
}
