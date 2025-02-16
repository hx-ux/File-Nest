import 'dart:async';

import 'package:file_nest/model/log_level.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';

simpleConfirmDialog(LogLevel logLevel, String message, String? fileName, {int showDuration=2000}) {
 
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

