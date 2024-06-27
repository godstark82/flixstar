import 'package:dooflix/features/history/presentation/pages/history_page.dart';
import 'package:dooflix/features/library/presentation/pages/library_screen.dart';
import 'package:dooflix/common/flat_button.dart';
import 'package:dooflix/common/heading_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptionScreen extends StatelessWidget {
  const MoreOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              )),
          title: Text('Login & Cloud Features soon...',
              maxLines: 2, style: Theme.of(context).textTheme.titleSmall),
          actions: [
            TextButton(
                onPressed: () {
                },
                child: Text('Login'))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              FlatBtn(
                iconData: Icons.history,
                text: 'History',
                onTap: () {
                  Get.to(() => HistoryPage());
                },
              ),
              SizedBox(),
            ]),
            SizedBox(height: 15),
            Heading2(text: 'Settings'),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey.withOpacity(0.5),
              ),
              title: Text('Settings'),
              onTap: () {
                
               //?
              },
            ),
            Heading2(text: 'APP'),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.grey.withOpacity(0.5),
              ),
              title: Text('Version'),
              subtitle: Text('1.0.0',
                  style: TextStyle(color: Colors.grey.withOpacity(0.9))),
            ),
            ListTile(
              onTap: () async {
                if (await canLaunchUrl(
                    Uri.parse('https://github.com/godstark82/crucifix'))) {
                  launchUrl(
                    Uri.parse('https://github.com/godstark82/crucifix'),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              leading: Icon(Icons.web_asset_outlined,
                  color: Colors.grey.withOpacity(0.5)),
              title: Text('Website'),
              subtitle: Text('Visit out website',
                  style: TextStyle(color: Colors.grey.withOpacity(0.9))),
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
                    'Hey Checkout this amazing app for streaming Movies, Web Series and Animes from here : - https://github.com/godstark82/crucifix/releases',
                    subject: 'Crucifix App');
              },
              leading: Icon(Icons.share, color: Colors.grey.withOpacity(0.5)),
              title: Text('Share App'),
            ),
          ],
        ),
      ),
    );
  }
}
