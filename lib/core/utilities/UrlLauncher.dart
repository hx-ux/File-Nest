import 'dart:io';

class UrlLaunchOptions {
  static void openFileExplorer(String path) async {
    if (Platform.isWindows) {
      print("opening file explorer");
      Process.run(
        "explorer",
        [path],
        workingDirectory: path,
      );
    }
  }

  static launchInBrowser(String url) async {
    if (Platform.isWindows) {
      Process.run(
        "explorer",
        [url],
      );
    }
  }
}
