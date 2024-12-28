import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:file_nest/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class AppSettings {
  //
  static const String appName = "File Nest";
  static const String appVersion = "0.0.1_alpha";
  static const bool isStable = false;
  //
  static const minSize = Size(400, 400);
  static const startSize = Size(400, 800);
  static const maxSize = Size(800, 800);
//
  static const logFileFileName = "file_nest_log.txt";
  static const settingsFolderName = "fileNest";
  static const appSettingsFileName = "app_settings.json";
  static final currPlatform = Platform.operatingSystem;
// dynamic appSettings
  static Object? getSettingsByKey(String key) {
    switch (key) {
      case "theme":
        return true;
      case "move":
        return false;
      default:
        return null;
    }
  }

  static setSettingsByKey(String key, Object? value) {
    // TODO: Implement setSettingsByKey method
  }
}

// Settings folder
// this is the folder where the logfile and the dbare stored
Future<Directory> getSettingFolderPath() async {
  final dir = await getApplicationDocumentsDirectory();
  final Directory _appDocDirFolder =
      Directory('${dir.path}/${AppSettings.settingsFolderName}');
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
  final file = File(p.join(dir.path, AppSettings.logFileFileName));
  if (file.existsSync()) return file;
  file.createSync();
  return file;
}

Future<File> getAppSettingsFilePath() async {
  final dir = await getSettingFolderPath();
  final file = File(p.join(dir.path, AppSettings.appSettingsFileName));
  if (file.existsSync()) return file;
  await appSettingsSetup();
  return file;
}

Future<File> appSettingsSetup() async {
  // Define the settings
  final Map<String, dynamic> payload = {
    "darkTheme": true,
    "alwaysMove": true,
  };

  String jsonString = jsonEncode(payload);
  final dir = await getSettingFolderPath();
  String filePath =
      File(p.join(dir.path, AppSettings.appSettingsFileName)).path;

  // Create the JSON file and write the data
  File jsonFile = File(filePath);
  jsonFile.createSync();
  await jsonFile.writeAsString(jsonString);
  // Use proper logging instead of print
  debugPrint('JSON file created at: $filePath');
  return jsonFile;
}
