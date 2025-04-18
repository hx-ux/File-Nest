import 'dart:io';
import 'package:file_nest/config.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/services/Dialogs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLogger {
  LogLevel logLevel;
  String? message;
  String? fileName;
  String? destination;
  DateTime? timestamp;
  IconData? icon;
  Color? color;

  static var timeStampFromUnix = DateFormat('dd.MM.yyyy HH:mm:ss', 'de_DE');

  String timeStamptoUnix() => DateTime.now().millisecondsSinceEpoch.toString();

  static Future<File> logFilePath() async => getLogFilePath();

  static void clearLogFile() async {
    final file = await logFilePath();
    final log = file.openWrite(mode: FileMode.write);
    log.write("");
    await log.close();
  }

  AppLogger({
    this.logLevel = LogLevel.copy,
    this.message = "none",
    this.fileName = "none",
    this.destination = "none",
  });

  void logToFile({bool showSnackbar = true}) {
    _writeLog(logLevel, message, fileName, destination);
    if (showSnackbar) {
      showSnackbarInformation(
          message??"unknow", fileName ?? "unknowm",
          infoType: logLevel);
    }
  }

  void _writeLog(LogLevel logtype, String? message, String? filename,
      String? destination) async {
    final file = await logFilePath();
    String logType = logtype.name;
    final log = file.openWrite(mode: FileMode.append);
    String timeStamp = timeStamptoUnix();

    log.writeln('$logType| $timeStamp | $message | $filename | $destination');
    log.close();
  }

  Future<List<AppLogger>> readLog() async {
    final file = await logFilePath();
    final lines = await file.readAsLines();

    List<AppLogger> logList = [];
    for (var element in lines) {
      logList.add(_readFromLogFile(element));
    }
    return logList;
  }

  AppLogger _readFromLogFile(String message) {
    {
      try {
        var parts = message.split('|');
        AppLogger appLogger = AppLogger();
        appLogger.logLevel = LogLevel.values.byName(parts[0]);
        int unixTimeStamp = int.tryParse(parts[1]) ?? 0;
        appLogger.timestamp = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp);
        appLogger.message = parts[2];
        appLogger.fileName = parts[3];
        appLogger.destination = parts[4];
        appLogger.icon = LogLevel.values.byName(parts[0]).icon ;
        appLogger.color = LogLevel.values.byName(parts[0]).attentioncolor;
        return appLogger;
      } catch (e) {
        return AppLogger();
      }
    }
  }

  void showSnackbarInformation(String msg, String? fileName,
          {required infoType}) =>
      simpleConfirmDialog(infoType, msg, fileName, showDuration: 1000);
}
