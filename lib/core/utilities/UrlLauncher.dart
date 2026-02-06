import 'dart:io';

import 'package:open_folder/open_folder.dart';

class UrlLaunchOptions {
  static void openInFileExplorer(String path) async {
    try {
      // TODO Log errors
      final _ = await OpenFolder.openFolder(path);
    } catch (e) {}
  }

  static launchInBrowser(String url) async {
    if (Platform.isWindows) {
      Process.run(
        "explorer",
        [url],
      );
    } else if (Platform.isLinux) {
      Process.run(
        "xdg-open",
        [url],
      );
    } else if (Platform.isMacOS) {
      Process.run(
        "open",
        [url],
      );
    }
  }
}
