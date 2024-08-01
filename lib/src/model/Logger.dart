import 'dart:io';

import 'package:file_nest/src/services/snackbar_information.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

enum LogLevel { debug, info, warning, error, copy, move }

class AppLogger {
  LogLevel logLevel;
  String message;
  String fileName;
  String destination;
  String? timestamp;
  IconData? icon;
  Color? col;

  DateFormat DateTimeFormat() => DateFormat('dd/MM/yy HH:mm:ss');
  String GetTimeStamp() => DateTimeFormat().format(DateTime.now()).toString();

  static Future<File> get logFilePath async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, "file_nest_log.txt"));
  }

  static void clearLogFile() async {
    final file = await logFilePath;
    file.openWrite(mode: FileMode.write).write("");
  }

  AppLogger({
    this.logLevel = LogLevel.copy,
    this.message = "",
    this.fileName = "none",
    this.destination = "none",
  });

  void logToFile({showSnackbar = true}) {
    _writeLog(logLevel, message, fileName, destination);

    if (showSnackbar) {
      String msg = "$message ";

      if (fileName != "none") {
        msg += "$fileName ";
      }
      if (destination != "none") {
        msg += "$destination ";
      }
      showSnackbarInformation(msg, infoType: logEnumToSnackBarenum(logLevel));
    }
  }

  void _writeLog(LogLevel logtype, String message, String filename,
      String destination) async {

    final file = await logFilePath;
    if (!await file.exists()) await file.create();
    final log = file.openWrite(mode: FileMode.append);
    log.writeln('${logtype.name}| ${GetTimeStamp()} | $message | $filename | $destination');
    log.close();
  }

  Future<List<AppLogger>> readLog() async {
    List<AppLogger> logList = [];
    final file = await logFilePath;

    for (var element in file.readAsLinesSync()) {
      logList.add(_logToClass(element));
    }
    return logList;
  }

  static _logToClass(String message) {
    {
      var parts = message.split('|');
      AppLogger appLogger = AppLogger();
      LogLevel logLevel = LogLevel.values.byName(parts[0]);
      appLogger.logLevel = logLevel;
      appLogger.timestamp = parts[1];
      appLogger.message = parts[2];
      appLogger.fileName = parts[3];
      appLogger.destination = parts[4];
      appLogger.icon = getIconForLogLevel(logLevel);
      appLogger.col = getColorForLogLevel(logLevel);
      return appLogger;
    }
  }

  static Color getColorForLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Colors.blue;
      case LogLevel.info || LogLevel.copy || LogLevel.move:
        return Colors.green;
      case LogLevel.warning || Colors.red:
      default:
        return Colors.blue;
    }
  }

  static SnackBarType logEnumToSnackBarenum(LogLevel level) {
    switch (level) {
      case LogLevel.debug || LogLevel.info || LogLevel.copy || LogLevel.move:
        return SnackBarType.success;
      case LogLevel.warning || LogLevel.error:
        return SnackBarType.error;
      default:
        return SnackBarType.error;
    }
  }

  static IconData getIconForLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return FluentIcons.bug_24_regular;
      case LogLevel.info:
        return FluentIcons.info_24_regular;
      case LogLevel.warning || LogLevel.error:
        return FluentIcons.text_bullet_list_24_regular;
      case LogLevel.copy:
        return FluentIcons.copy_arrow_right_24_regular;
      case LogLevel.move:
        return FluentIcons.arrow_move_24_regular;
      default:
        return FluentIcons.bug_24_regular;
    }
  }
}
