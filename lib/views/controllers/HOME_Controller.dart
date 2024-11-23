import 'dart:io';

import 'package:file_copy/file_copy.dart';
import 'package:file_nest/core/theme/app_theme.dart';
import 'package:file_nest/core/utilities/UrlLauncher.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/model/db.dart';
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
  //gui stuff
  RxBool isOverNode = false.obs;
  RxInt dropTragetIdentifier = 0.obs;

  RxBool isTransferingFile = false.obs;
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

  void fileTransferOperation(
      List<String> originalFiles, String targetPath) async {

    List<File> files = [];
    if (originalFiles.isNotEmpty) {
      
      for (var element in originalFiles) {
        print(element);
        files.add(File(element));
        await copyFile(File(element), targetPath);
      }
    }
  }

  DialogAction(fileName) {
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

  Future<LogLevel> copyFile(File originalFile, String destinationPath) async {
    print("begin copy file");

    String destinationFullPath =
        p.join(destinationPath, p.basename(originalFile.path));

    if (File(destinationFullPath).existsSync()) {
      DialogSimpleConfirm(
          LogLevel.error, "file arlready exists", originalFile.path);
      return LogLevel.duplicate;
    }

    isTransferingFile.value = true;

    DialogAction(
      originalFile.path,
    );
    await FileCopy.copyFile(
      originalFile,
      destinationFullPath,
      onChangeProgress: (progress) {
        transferProgress.value = progress.progress;
        print(progress.progress);
      },
    );
    isTransferingFile.value = false;
    Navigator.pop(Get.context!);
    DialogSimpleConfirm(LogLevel.copy, "File copied", originalFile.path,
        showDuration: 1000);
    return LogLevel.copy;
  }

  Future<void> openFileExplorer(String url) async =>
      UrlLaunchOptions.openFileExplorer(url);

  void changeMode(int idx) =>
      copyOrMove.value = idx == 0 ? CopyOrMove.Copy : CopyOrMove.Move;
}
