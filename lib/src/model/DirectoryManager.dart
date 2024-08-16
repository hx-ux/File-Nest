// if (!await file.exists()) await file.create();
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<Directory> get fileNestBaseDir async {
  final documentsDir = await getApplicationDocumentsDirectory();
  Directory BaseDir=Directory(p.join(documentsDir.path, "FileNest"));
  if (!await BaseDir.exists()) await BaseDir.create();
  return BaseDir;
}


  Future<File> get logFilePath async {
    final dir = await fileNestBaseDir;
    var logFile=File(p.join(dir.path, "file_nest_log.txt"));
     if (!await logFile.exists()) await logFile.create();
    return logFile;
  }