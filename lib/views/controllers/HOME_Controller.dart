import 'dart:io';

import 'package:file_copy/file_copy.dart';
import 'package:file_nest/core/theme/app_theme.dart';
import 'package:file_nest/core/utilities/Explorer.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/model/db.dart';

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

  var copyOrMove = CopyOrMove.Copy.obs;
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
        message: "error creating folder",
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

void copyFile(File originalFile, String destinationPath) async {
  try {
    // Check if file exists in the destination path
    final File newFile = File(destinationPath);

    if (await newFile.exists()) {
      print("File already exists");
      return;
    }

    // Display loading indicator

    await originalFile.copy(destinationPath);
    print('File copied to $destinationPath');


  } catch(e) {
      AppLogger(
                logLevel: LogLevel.error,
                message: 'copied file',
                fileName: basename((originalFile.path)))
            .logToFile();
  }
}





  Future<void> _copyMoveFile(File originalFile, File destinationFolder,
      String sourceFilePath, bool deleteAfterTransfer) async {
    String destinationFile = "${destinationFolder.path}\\$sourceFilePath";

    try {
      // check if file exits
      if (fileExists(destinationFile)) {
        AppLogger(
                logLevel: LogLevel.error,
                message: "file already exists",
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

        Get.back(closeOverlays: true);

        AppLogger(
                logLevel: LogLevel.copy,
                message: !deleteAfterTransfer ? 'copied file' : "moved file",
                fileName: basename((File(destinationFile).path)))
            .logToFile();
      }

          
      // close the overlay
    } catch (e) {
      Get.back(closeOverlays: true);

      AppLogger(
        logLevel: LogLevel.error,
        message: !deleteAfterTransfer ? 'error copying file' : "error moving file",
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

  Future<void> openFileExplorer(String url) async {
    UrlLaunchOptions.openFileExplorer(url);
  }

  void changeMode(int idx) =>
      copyOrMove.value = idx == 0 ? CopyOrMove.Copy : CopyOrMove.Move;
}
