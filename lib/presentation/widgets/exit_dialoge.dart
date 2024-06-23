import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> confirmExitDialoge(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Confirm Exit ?'),
            content: Text('Are you sure you want to leave this application'),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
              TextButton(
                  onPressed: () => SystemNavigator.pop(animated: true),
                  child: Text('Exit')),
            ],
          ));
}
