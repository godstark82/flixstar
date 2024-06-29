import 'package:flixstar/common/update_screen.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/core/utils/my_snack.dart';
import 'package:flixstar/features/history/presentation/pages/history_page.dart';
import 'package:flixstar/features/library/presentation/pages/library_screen.dart';
import 'package:flixstar/common/flat_button.dart';
import 'package:flixstar/common/heading_2.dart';
import 'package:flixstar/features/settings/presentation/pages/settings_screen.dart';
import 'package:flixstar/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptionScreen extends StatelessWidget {
  const MoreOptionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'FlixStar',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 24, shadows: [
              Shadow(color: Colors.black, blurRadius: 16),
            ]),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => SettingScreen());
                },
                icon: Icon(Icons.settings))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SizedBox(),
              FlatBtn(
                iconData: Icons.list,
                text: 'My List',
                onTap: () {
                  Get.to(() => LibraryScreen());
                },
              ),
              SizedBox(width: 20),
              FlatBtn(
                iconData: Icons.history,
                text: 'History',
                onTap: () {
                  Get.to(() => HistoryPage());
                },
              ),
              SizedBox(),
            ]),
            SizedBox(height: context.height * 0.25),
            Heading2(text: 'APP'),
            ListTile(
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(
                    'https://github.com/godstark82/flixstar/releases'))) {
                  launchUrl(
                    Uri.parse(
                        'https://github.com/godstark82/flixstar/releases'),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              leading: Icon(Icons.web_asset_outlined,
                  color: Colors.grey.withOpacity(0.5)),
              title: Text('Website'),
            ),
            ListTile(
              onTap: () {
                showAboutDialog(context: context);
              },
              leading: Icon(Icons.contact_page_rounded,
                  color: Colors.grey.withOpacity(0.5)),
              title: Text('About & Licenses'),
            ),
            ListTile(
              onTap: () async {
                await Share.share(
                    'Hey Checkout this amazing app for streaming Movies, Web Series and Animes from here : - https://github.com/godstark82/flixstar/releases',
                    subject: 'Crucifix App');
              },
              leading: Icon(Icons.share, color: Colors.grey.withOpacity(0.5)),
              title: Text('Share App'),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.grey.withOpacity(0.5),
              ),
              title: Text('Check for Updates'),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Checking'),
                    content: UnconstrainedBox(
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
                await checkForNewUpdate();
                Get.back();
                if (isUpdateAvailable) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Update Available'),
                            content: Text('New update available for FlixStar'),
                            actions: [
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () =>
                                      Get.to(() => UpdateWarningScreen()),
                                  child: Text('Update'))
                            ],
                          ));
                } else {
                  MySnackBar.showgreenSnackBar(context,
                      message: 'Already up-to-date');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
