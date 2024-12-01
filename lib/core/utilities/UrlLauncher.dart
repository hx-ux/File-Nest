import 'dart:io';

class UrlLaunchOptions {
  static void openFileExplorer(String path) async {
    if (Platform.isWindows) {
      Process.run(
        "explorer",
        [path],
        workingDirectory: path,
      );
    } else if (Platform.isLinux) {
      Process.run(
        "xdg-open",
        [path],
      );
    }
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
    }
  }
}
