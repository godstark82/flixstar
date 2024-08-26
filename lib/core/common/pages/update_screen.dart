import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateWarningScreen extends StatelessWidget {
  const UpdateWarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('FlixStar', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        backgroundColor: Colors.black12,
        body: Center(
          child: AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: Icon(
              Icons.warning,
              color: Colors.yellow,
              size: 45,
            ),
            iconPadding: EdgeInsets.symmetric(vertical: 12),
            title: Center(
              child: Text(
                'Update Available',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: Text('Please update the app to the latest version',
                style: TextStyle(color: Colors.grey)),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              if (!forceUpdate)
                TextButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        return;
                      }
                      runApp(App());
                    },
                    child: Text('Skip')),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Colors.purple.withOpacity(0.1))),
                  onPressed: () {
                    launchUrl(Uri.parse(
                        'flixstar.shop'));
                  },
                  child: Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}
