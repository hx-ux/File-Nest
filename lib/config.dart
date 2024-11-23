import 'dart:io';
import 'dart:ui';

import 'package:file_nest/model/Logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class AppSettings {
  static const String appName = "File Nest";
  static const String appVersion = "0.0.1_alpha";
  static const bool isStable = false;
  static const minSize = Size(400, 400);
  static const startSize = Size(400, 800);
  static const maxSize = Size(800, 800);
}

const logFileFileName = "file_nest_log.txt";
const settingsFolderName = "fileNest";
// Settings folder
// this is the folder where the logfile and the dbare stored
Future<Directory> getSettingFolderPath() async {
  final dir = await getApplicationDocumentsDirectory();
  final Directory _appDocDirFolder =
      Directory('${dir.path}/$settingsFolderName');
  if (await _appDocDirFolder.exists()) {
    return _appDocDirFolder;
  } else {
    final Directory _appDocDirNewFolder =
        await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder;
  }
}

Future<File> getLogFilePath() async {
  final dir = await getSettingFolderPath();
  final file = File(p.join(dir.path, logFileFileName));
  if (file.existsSync()) return file;
  file.createSync();
  return file;
}
