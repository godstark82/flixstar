import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flutter/foundation.dart';

Future<void> fetchFirebaseData() async {
  if (!kIsWeb) {
    if (!Platform.isWindows) {
      try {
        final db = FirebaseFirestore.instance;
        final ref = await db.collection('config').doc('settings').get();
        final settings = ref.data();
        log(settings.toString());
        bool _streamMode = settings?['streamMode'] ?? false;
        bool _showAds = settings?['showAds'] ?? false;
        bool _forceUpdate = settings?['forceUpdate'] ?? false;
        streamMode = _streamMode;
        showAds = _showAds;
        forceUpdate = _forceUpdate;
      } catch (e) {
        debugPrint(e.toString());
        rethrow;
      }
    }
  }
}
