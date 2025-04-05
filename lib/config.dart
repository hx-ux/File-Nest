import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:file_nest/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:settings_yaml/settings_yaml.dart';

class AppSettings {
  //
  static const String appName = "File Nest";
  static const String appVersion = "0.0.1_alpha";
  static const bool isStable = false;
  //
  static const Size minSize = Size(400, 400);
  static const Size startSize = Size(400, 800);
  static const Size maxSize = Size(800, 800);
//
  static const logFileName = "file_nest_log.txt";
  static const settingsFolderName = "fileNest";
  static const appSettingsFileName = "app_settings.yaml";
  static final String currPlatform = Platform.operatingSystem;
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
  final file = File(p.join(dir.path, AppSettings.logFileName));
  if (await file.exists()) return file;
  await file.create();
  return file;
}

Future<File> getAppSettingsFilePath() async {
  final dir = await getSettingFolderPath();
  final file = File(p.join(dir.path, AppSettings.appSettingsFileName));
  if (file.existsSync()) return file;
  file.createSync();
  return file;
}

Future<void> saveSettings(Map<String, int> values) async {
  final file = await getAppSettingsFilePath();
  final settings = SettingsYaml.load(pathToSettings: file.path);
  for (var element in values.entries) {
    settings[element.key] = element.value;
  }
  await settings.save();
}

Future<Map<String, int>> loadSettings() async {
  final file = await getAppSettingsFilePath();
  final settings = SettingsYaml.load(pathToSettings: file.path);

  assert(settings.validInt('themeMode'), 'Should be a int');

  return {
    'themeMode': settings['themeMode']?.toInt() ?? 0,
  };
}
