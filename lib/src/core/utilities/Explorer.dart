import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class FileExplorer {
  static void openFileExplorer(String path) async {
    if (Platform.isWindows) {
      String url = 'file://$path';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isLinux) {
      // Todo not yet implemented
    }
  }
}
