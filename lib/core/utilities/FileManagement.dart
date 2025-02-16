  import 'dart:io';
import 'package:path/path.dart' as p;
bool doesFileExits(
    File originalFile,
    String destinationPath,
  ) {
    String destinationFullPath =
        p.join(destinationPath, p.basename(originalFile.path));
    return (File(destinationFullPath).existsSync());
  }