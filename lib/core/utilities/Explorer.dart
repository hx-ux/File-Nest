import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class UrlLaunchOptions {
  static void openFileExplorer(String path) async {
    Uri uri = Uri.parse(path);

    if (await UrlLauncherPlatform.instance.canLaunch(path)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $path');
    }
  }

  static Future<void> launchInBrowser(String url) async {
    if (await UrlLauncherPlatform.instance.canLaunch(url)) {
      await UrlLauncherPlatform.instance.launch(
        url,
        useSafariVC: false,
        useWebView: true,
        enableJavaScript: false,
        enableDomStorage: false,
        universalLinksOnly: false,
        headers: <String, String>{},
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
