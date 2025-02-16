import 'dart:io';

class UrlLaunchOptions {
  static void openInFileExplorer(String path) async {
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
    } else if (Platform.isMacOS) {
      // no suppport for macos yet
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
    } else if (Platform.isMacOS) {
      // no suppport for macos yet

    }
  }
}
