import 'dart:io';
import 'package:file_nest/config.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/services/Dialogs.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLogger {
  LogLevel logLevel;
  String message;
  String fileName;
  String destination;
  String? timestamp;
  IconData? icon;
  Color? color;

  // DateFormat DateTimeFormat() => DateFormat('dd/MM/yy HH:mm:ss');
  String GetTimeStampAsString() {
    var formatter = DateFormat('dd.MM.yyyy HH:mm:ss', 'de_DE');
    return formatter.format(DateTime.now());
  }

  static Future<File> logFilePath() async => getLogFilePath();

  static void clearLogFile() async {
    final file = await logFilePath();
    final log = file.openWrite(mode: FileMode.write);
    log.write("");
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
      showSnackbarInformation(
          message, fileName != "none" ? fileName : destination,
          infoType: logLevel);
    }
  }

  void _writeLog(LogLevel logtype, String message, String filename,
      String destination) async {
    final file = await logFilePath();
    String logType = logtype.name;
    final log = file.openWrite(mode: FileMode.append);
    String timeStamp = GetTimeStampAsString();

    log.writeln('$logType| $timeStamp | $message | $filename | $destination');
    log.close();
  }

  Future<List<AppLogger>> readLog() async {
    final file = await logFilePath();
    final lines = await file.readAsLines();
    return lines.map(_logToClass).toList();
  }

  AppLogger _logToClass(String message) {
    {
      try {
        var parts = message.split('|');
        AppLogger appLogger = AppLogger();
        appLogger.logLevel = LogLevel.values.byName(parts[0]);
        appLogger.timestamp = parts[1];
        appLogger.message = parts[2];
        appLogger.fileName = parts[3];
        appLogger.destination = parts[4];
        appLogger.icon = LogLevel.values.byName(parts[0]).icon;
        appLogger.color = LogLevel.values.byName(parts[0]).attentioncolor;
        return appLogger;
      } catch (e) {
        return new AppLogger();
      }
    }
  }

  void showSnackbarInformation(String msg, String? fileName,
          {required infoType}) =>
      DialogSimpleConfirm(infoType, msg, fileName, showDuration: 1000);
}
