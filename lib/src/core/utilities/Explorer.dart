import 'dart:io';

import 'package:open_dir/open_dir.dart';
import 'package:url_launcher/url_launcher.dart';

class FileExplorer {
  static void openFileExplorer(String path) async => await OpenDir().openNativeDir(path: path);
}
