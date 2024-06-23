import 'package:flutter/material.dart';

class QualitySettingScreen extends StatelessWidget {
  const QualitySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Quality Settings'), centerTitle: true),
        body: ListView(
          children: [
            ListTile(title: Text('Carousel Image Quality')),
            ListTile(title: Text('Card Image Quality'))
          ],
        ));
  }
}
