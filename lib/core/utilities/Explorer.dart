import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class FileExplorer {
  static void openFileExplorer(String path) async {
    Uri uri = Uri.parse(path);
    if (Platform.isWindows) {
      String url = 'file://$path';
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
