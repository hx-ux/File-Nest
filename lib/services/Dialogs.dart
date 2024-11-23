import 'dart:async';

import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/views/bindings/binding.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';

DialogSimpleConfirm(LogLevel logLevel, String message, String? fileName, {int showDuration=2000}) {
 
   Timer(Duration(milliseconds: showDuration), () {
    Navigator.pop(Get.context!);
  });
  _DialogSimpleConfirm(logLevel, message, fileName);
}

_DialogSimpleConfirm(LogLevel logLevel, String message, String? fileName) {
  Dialogs.bottomMaterialDialog(
      msg: message,
      title: logLevel.description,
      color: logLevel == LogLevel.error ? Colors.red : Colors.green,
      context: Get.context!,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          child: Text('Dismiss',
              style: const TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ]);
}

FileTransferProgressBar(var transferProgress, bool isIfnihes) {
  return Obx(
    () => Column(
      children: [
        LinearProgressIndicator(value: (transferProgress.value)),
        Text(
          "${((transferProgress.value * 100).roundToDouble()).clamp(0, 100).toInt()}%",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ],
    ),
  );
}
