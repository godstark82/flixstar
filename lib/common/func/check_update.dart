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
    String gitHubVersion = response.data['tag_name'];
    final packageInfo = await PackageInfo.fromPlatform();
    final List<String> cloudVersion = gitHubVersion.split('+');
    print(cloudVersion);
    final String localVersion = packageInfo.version;
    print('Cloud Version: ${cloudVersion.first}');
    print('Local Version: $localVersion');
    if (cloudVersion.first == localVersion) {
      return;
    } else {
      isUpdateAvailable = true;
    }
  }
}
