import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

enum LogLevel { debug, info, warning, error, copy, move }

extension LogLevelToString on LogLevel {
  String get label {
    switch (this) {
      case LogLevel.debug:
        return 'Debug';
      case LogLevel.info:
        return 'Info';
      case LogLevel.warning:
        return 'Warning';
      case LogLevel.error:
        return 'Error';
      case LogLevel.copy:
        return 'Copied';
      case LogLevel.move:
        return 'Move';
    }
  }
}

class AppLogger {
  LogLevel logLevel;
  String message;
  DateTime? timestamp;

  AppLogger.LogVariableTime(this.logLevel, this.message, this.timestamp);

  AppLogger({this.logLevel = LogLevel.copy, this.message = ""});

  void logToFile() => _writeLog(logLevel, message);

  void _writeLog(LogLevel type, String line) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, "log.txt"));
    if (!await file.exists()) await file.create();
    final log = file.openWrite(mode: FileMode.append);
    log.writeln('test | ${DateTime.now().toIso8601String()} | $line');
    log.close();
  }

  static Future<List<AppLogger>> readLog() async {
    List<AppLogger> logList = [];
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, "log.txt"));
    var pp = file.readAsLinesSync();
    for (var element in pp) {
      logList.add(_logToClass(element)); 
    }
    return logList;

  }

  static _logToClass(String message) {
    {
      var parts = message.split('|');
      AppLogger appLogger = AppLogger();
      // appLogger.logLevel = LogLevel.values.byName(parts[0]);
      appLogger.logLevel = LogLevel.copy;
      appLogger.timestamp = DateTime.now();
      appLogger.message = parts[2];
      return appLogger;
    }
  }
}
