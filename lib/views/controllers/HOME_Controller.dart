import 'dart:io';

import 'package:file_copy/file_copy.dart';
import 'package:file_nest/core/theme/app_theme.dart';
import 'package:file_nest/core/utilities/UrlLauncher.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/model/db.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/services/Dialogs.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

enum CopyOrMove {
  Copy,
  Move,
}

class HOME_Controller extends GetxController {
  RxList<TargetArtefact> allArtefacts = <TargetArtefact>[].obs;

  ThemeData themeData = appThemeDataDark;

  var copyOrMove = CopyOrMove.Copy.obs;
  TargetArtefact? selectedNode = TargetArtefact("", "");
  //
  RxBool isOverNode = false.obs;
  RxInt dropTragetIdentifier = 0.obs;
  //
  RxDouble transferProgress = 0.0.obs;
  //

  @override
  void onInit() {
    super.onInit();
    loadAllArtefact();
  }

  void loadAllArtefact() async {
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
          fileName: selectedDirectory,
        ).logToFile();
        update();
      }
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "error creating folder",
        fileName: "$e",
      ).logToFile();
    }
  }

  void deleteArtefact(TargetArtefact id) async {
    try {
      DBApdater.deleteArteFact(id.id);
      allArtefacts.removeWhere((element) => element.id == id.id);
      AppLogger(
        logLevel: LogLevel.info,
        message: "Entry deleted",
        fileName: id.url,
      ).logToFile();
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "Failed to delete Entry ",
        fileName: id.url,
      ).logToFile();
    }
  }

  void fileTransferOperation(List<String> inputFiles, String targetPath) async {
    if (inputFiles.isEmpty) return;

    List<File> ErrorFiles = [];

    List<File> toCopyFiles = inputFiles
        .map((filePath) => File(filePath))
        .where((file) => !doesFileExits(file, targetPath))
        .toList();

    if (toCopyFiles.isEmpty) return;

    for (var i = 0; i < toCopyFiles.length; i++) {
      await copyFile(toCopyFiles[i], targetPath, toCopyFiles.length, i);
    }
    DialogSimpleConfirm(
      LogLevel.copy,
      toCopyFiles.length == 1
          ? "copied file"
          : "copied ${toCopyFiles.length} files",
      toCopyFiles.length == 1 ? toCopyFiles[0].path : null,
      showDuration: 1000,
    );
  }

  CopyDialog(fileName) {
    Dialogs.bottomMaterialDialog(
        title: 'Copy file',
        msg: p.basename((fileName)),
        context: Get.context!,
        customView: FileTransferProgressBar(transferProgress, false),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(Get.context!);
            },
            text: 'Abort',
            iconData: Icons.delete,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  bool doesFileExits(
    File originalFile,
    String destinationPath,
  ) {
    String destinationFullPath =
        p.join(destinationPath, p.basename(originalFile.path));
    return (File(destinationFullPath).existsSync());
  }

  Future<LogLevel> copyFile(File originalFile, String destinationPath,
      int copyListLen, int currPos) async {
    try {
      String destinationFullPath =
          p.join(destinationPath, p.basename(originalFile.path));

      CopyDialog(p.basename(originalFile.path));
      try {
        await FileCopy.copyFile(
          originalFile,
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
          fileName: originalFile.path,
        ).logToFile();
        Navigator.pop(Get.context!);
        return LogLevel.error;
      }
      AppLogger(
        logLevel: LogLevel.copy,
        message: "Copied file",
        fileName: originalFile.path,
      ).logToFile();
      Navigator.pop(Get.context!);
      return LogLevel.copy;
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "Failed to copy file",
        fileName: originalFile.path,
      ).logToFile();
      return LogLevel.error;
    }
  }

  Future<void> openFileExplorer(String url) async =>
      UrlLaunchOptions.openFileExplorer(url);

  void changeMode(int idx) =>
      copyOrMove.value = idx == 0 ? CopyOrMove.Copy : CopyOrMove.Move;
}
