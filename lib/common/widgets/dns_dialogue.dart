import 'package:flutter/material.dart';

AlertDialog dnsDialogue(BuildContext context) {
  return AlertDialog(
      title: Text('DNS Requirement'),
      content: Text(
          'If you are seeing NOT AVAILABLE in every Movie and Series. You will have to set your Device DNS to either "dns.google" or "dns.adguard.com".'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'))
      ]);
}
