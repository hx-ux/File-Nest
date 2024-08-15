import 'package:open_dir/open_dir.dart';

class FileExplorer {
  static void openFileExplorer(String path) async =>
      await OpenDir().openNativeDir(path: path);
}
