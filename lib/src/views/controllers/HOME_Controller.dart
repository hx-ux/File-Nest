import 'dart:io';

import 'package:file_copy/file_copy.dart';
import 'package:file_nest/src/core/theme/app_theme.dart';
import 'package:file_nest/src/core/utilities/Explorer.dart';
import 'package:file_nest/src/model/Logger.dart';
import 'package:file_nest/src/model/TargetArtefact.dart';
import 'package:file_nest/src/model/db.dart';
import 'package:file_nest/src/services/snackbar_information.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

enum CopyOrMove {
  Copy,
  Move,
}

class HOME_Controller extends GetxController {
  RxList<TargetArtefact> allArtefacts = <TargetArtefact>[].obs;

  ThemeData themeData = appThemeDataDark;

  final copyOrMove = CopyOrMove.Copy.obs;
  TargetArtefact? selectedNode = TargetArtefact("", "");
  
  //gui stuff
  RxBool isOverNode = false.obs;
  RxInt dropTragetIdentifier = 0.obs;
  RxBool isTransferingFile = false.obs;
  var showTransferProgress = false.obs;
  RxDouble transferProgress = 0.0.obs;
  //

  @override
  void onInit() async {
    super.onInit();
    loadAllArtefact();
  }

  void loadAllArtefact() async {
    DBApdater.getAllTargetArtefacts()
        .then((value) => allArtefacts.value = value);
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
          fileName: selectedDirectory.toString(),
        ).logToFile();
        update();
      }
    } catch (e) {
      AppLogger(
        logLevel: LogLevel.error,
        message: "cannot add folder $e",
        fileName: "$e",
      ).logToFile();
    }
  }

  void deleteArtefact(TargetArtefact id) async {
    DBApdater.deleteArteFact(id.id);
    allArtefacts.removeWhere((element) => element.id == id.id);

    AppLogger(
      logLevel: LogLevel.info,
      message: "Entry deleted",
      fileName: id.name.toString(),
    ).logToFile();
  }

  void moveOrCopyFile(File originalFile, String targetPath) async {
    // display the loading overlay
    String sourceFilePath = p.basename(originalFile.path);
    bool deleteFileAfterTransfer = copyOrMove.value == CopyOrMove.Move;

    await _copyMoveFile(originalFile, File(targetPath), sourceFilePath,
        deleteFileAfterTransfer);
  }

  Future<void> _copyMoveFile(File originalFile, File destinationFolder,
      String sourceFilePath, bool deleteAfterTransfer) async {
    String destinationFile = "${destinationFolder.path}\\$sourceFilePath";
    String message = "file already exists";

    try {
      // check if file exits
      if (fileExists(destinationFile)) {
        AppLogger(
                logLevel: LogLevel.error,
                message: message,
                fileName: basename((File(destinationFile).path)))
            .logToFile();
      } else {
        showLoadingScreen();

        isTransferingFile = true.obs;
        await FileCopy.copyFile(
          originalFile,
          destinationFile,
          onChangeProgress: (progress) {
            transferProgress.value = progress.progress;
          },
        );

        if (deleteAfterTransfer) {
          originalFile.delete();
        }

        message = !deleteAfterTransfer ? 'copied file' : "moved file";
        Get.back(closeOverlays: true);
       
        AppLogger(
                logLevel: LogLevel.copy,
                message: message,
                fileName: basename((File(destinationFile).path)))
            .logToFile();
      }

      message =
          !deleteAfterTransfer ? 'error copying file' : "error moving file";
      // close the overlay
    } catch (e) {
      Get.back(closeOverlays: true);

      AppLogger(
        logLevel: LogLevel.error,
        message: message,
        fileName: basename((File(destinationFile).path)),
      ).logToFile();
    }
    isTransferingFile = false.obs;
  }

  bool fileExists(String path) => File(path).existsSync();

  showLoadingScreen() {
    Get.dialog(Dialog(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          Obx(
            () => LinearProgressIndicator(value: (transferProgress.value)),
          ),
          Obx(
            () => Text(
              "${((transferProgress.value * 100).roundToDouble()).clamp(0, 100).toInt()}%",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    ));
  }

  void openFileExplorer(String url) => FileExplorer.openFileExplorer(url);

  void changeMode(int idx) =>
      copyOrMove.value = idx == 0 ? CopyOrMove.Copy : CopyOrMove.Move;
}
