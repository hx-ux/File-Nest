import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:file_copy/file_copy.dart';
import 'package:file_nest/core/theme/app_theme.dart';
import 'package:file_nest/core/utilities/FileManagement.dart';
import 'package:file_nest/core/utilities/UrlLauncher.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/model/db.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/routes/app_pages.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

enum CopyOrMove {
  Copy,
  Move,
}

class HOME_Controller extends GetxController {
  RxList<TargetArtefact> allArtefacts = <TargetArtefact>[].obs;

  var copyOrMove = CopyOrMove.Copy.obs;
  TargetArtefact? selectedNode;
  RxBool isOverNode = false.obs;
  RxInt dropTragetIdentifier = 0.obs;
  RxDouble transferProgress = 0.0.obs;

  RxString currentProcressedFile = "".obs;
  RxBool currentFileProcessFinished = false.obs;

  CancelableOperation? _copyOperation;
  RxBool copyOperationFinished = false.obs;

  StreamController<bool> streamController = StreamController<bool>();

  @override
  void onInit() async {
    super.onInit();
    await loadAllArtefact();
  }

  Future<void> loadAllArtefact() async {
    try {
      var value = await DBApdater.getAllTargetArtefacts();
      allArtefacts.value = value;
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "Failed to load artefacts",
        fileName: "$e",
      ).logToFile();
    }
  }

  Future<void> addArtefact() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        TargetArtefact node =
            TargetArtefact(selectedDirectory, const Uuid().v1());
        allArtefacts.add(node);
        await DBApdater.addArtefact(node);

        AppLogger(
          logLevel: LogLevel.info,
          message: "created folder",
          fileName: p.basename(selectedDirectory),
        ).logToFile(showSnackbar: false);
        update();
      }
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "$e",
        fileName: 'Unknown directory',
      ).logToFile();
    }
  }

  void deleteArtefact(TargetArtefact id) async {
    try {
      await DBApdater.deleteArteFact(id.id);
      allArtefacts.removeWhere((element) => element.id == id.id);
      AppLogger(
        logLevel: LogLevel.info,
        message: "Entry deleted",
        fileName: p.basename(id.url),
      ).logToFile();
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "Failed to delete Entry ",
        fileName: p.basename(id.url),
      ).logToFile();
    }
  }

  void fileTransferOperation(List<String> inputFiles, String targetPath) async {
    copyOperationFinished.value = false;
    try {
      if (copyOrMove.value == CopyOrMove.Copy) {
        if (inputFiles.isEmpty) throw "No files selected";

        List<File> toCopyFiles = inputFiles
            .map((filePath) => File(filePath))
            .where((file) => !doesFileExits(file, targetPath))
            .toList();

        if (toCopyFiles.isEmpty) throw "No files to copy";
        Get.toNamed(Routes.FileOperation);
        _copyOperation = CancelableOperation.fromFuture(
          copyFiles(toCopyFiles, targetPath),
          onCancel: () => {},
        ).then((_) async {
          copyOperationFinished.value = true;
          await Future.delayed(Duration(seconds: 1));
          Get.toNamed(Routes.HOME);
        });
      }
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "$e",
        fileName: "",
      ).logToFile();
    }
  }

  Future<void> copyFiles(
    List<File> originalFile,
    String destinationPath,
  ) async {
    List<bool> copyResults = [];
    for (var i = 0; i < originalFile.length; i++) {
      currentProcressedFile.value = originalFile[i].path;
      final p = await copyFileOperation(originalFile[i], destinationPath);
      copyResults.add(p);
    }
    update();
  }

  Future<bool> copyFileOperation(File toCopyFile, String targetPath) async {
    String destinationFullPath =
        p.join(targetPath, p.basename(toCopyFile.path));

    try {
      await FileCopy.copyFile(
        toCopyFile,
        destinationFullPath,
        onChangeProgress: (progress) {
          transferProgress.value = progress.progress;
          print(progress.progress);
        },
      );
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "Error during file copy: $e",
        fileName: toCopyFile.path,
        destination: destinationFullPath,
      ).logToFile(showSnackbar: false);
      return false;
    }
    AppLogger(
      logLevel: LogLevel.copy,
      message: "Copied file",
      fileName: toCopyFile.path,
      destination: destinationFullPath,
    ).logToFile(showSnackbar: false);
    return true;
  }
}



