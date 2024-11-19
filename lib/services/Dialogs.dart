import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';

DialogSimpleConfirm(LogLevel logLevel, String message, String fileName) {
  Dialogs.bottomMaterialDialog(
      msg: message,
      title: AppLogger.logEnumToSnackBarenum(logLevel),
      color: Colors.white,
      context: Get.context!,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          child: Text('Dismiss'),
        ),
      ]);
}
