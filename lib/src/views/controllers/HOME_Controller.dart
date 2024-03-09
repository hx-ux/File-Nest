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
import 'package:uuid/uuid.dart';

enum CopyOrMove {
  Copy,
  Move,
}

class HOME_Controller extends GetxController {
  RxList<TargetArtefact> allArtefacts = <TargetArtefact>[].obs;

  ThemeData themeData = appThemeData;

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
    for (var element in allArtefacts) {
      print(element.name);
    }
  }

  Future<void> addArtefact() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        print(selectedDirectory);
        TargetArtefact node = TargetArtefact(selectedDirectory, const Uuid().v1());
        allArtefacts.add(node);
        await DBApdater.addUser(node);
      }
    } catch (e) {
      print('An error occurred while adding artefact: $e');
    }
  }

  void deleteArtefact(TargetArtefact id) async {
    DBApdater.deleteArteFact(id.id);
    allArtefacts.removeWhere((element) => element.id == id.id);
    showSnackbarInformations("Entry ${id.name} deleted",
        infoType: SnackBarType.success);
  }

  void moveOrCopyFile(File originalFile, String targetPath) async {
    // display the loading overlay
    String sourceFilePath = p.basename(originalFile.path);
    bool deleteFileAfterTransfer = false;
    if (copyOrMove == CopyOrMove.Move) {
      deleteFileAfterTransfer = true;
    }

    await _copyMoveFile(originalFile, File(targetPath), sourceFilePath,
        deleteFileAfterTransfer);
  }

  Future<void> _copyMoveFile(File originalFile, File destinationFolder,
      String sourceFilePath, bool deleteAfterTransfer) async {
    showLoading();
    try {
      isTransferingFile = true.obs;
      await FileCopy.copyFile(
        originalFile,
        "${destinationFolder.path}\\$sourceFilePath",
        onChangeProgress: (progress) {
          transferProgress.value = progress.progress;
          print(progress.progress);
        },
      );
      if (deleteAfterTransfer) {
        originalFile.delete();
      }
      // close the overlay
      Get.back(closeOverlays: true);
      showSnackbarInformations("file copied", infoType: SnackBarType.success);
      AppLogger(
        logLevel: LogLevel.copy,
        message: !deleteAfterTransfer ? 'copied file' : "moved file",
      ).logToFile();
    } catch (e) {
      Get.back(closeOverlays: true);
      AppLogger(
        logLevel: LogLevel.error,
        message:
            !deleteAfterTransfer ? 'error copying file' : "error moving file",
      ).logToFile();
      showSnackbarInformations("error", infoType: SnackBarType.error);
    }
    isTransferingFile = false.obs;
  }

  showLoading() {
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
