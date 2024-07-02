import 'package:dio/dio.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> checkForNewUpdate() async {
  if (!kIsWeb) {
    final dio = sl<Dio>();
    const url =
        'https://api.github.com/repos/godstark82/flixstar/releases/latest';
    final response = await dio.get(url);
    final packageInfo = await PackageInfo.fromPlatform();
    print('latest Version: ${response.data['tag_name']}');
    final String cloudVersion = response.data['tag_name'];
    final String localVersion =
        'v${packageInfo.version}+${packageInfo.buildNumber}';
    if (cloudVersion == localVersion) {
      return;
    } else {
      isUpdateAvailable = true;
    }
  }
}
