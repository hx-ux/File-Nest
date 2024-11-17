import 'package:file_nest/core/theme/colors.style.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType {
  success,
  error,
}

SnackbarController showSnackbarInformations(String message,
    {infoType = SnackBarType.success}) {
  return Get.snackbar(
    infoType == SnackBarType.success ? "success" : "Error",
    message,
    colorText: Colors.white,
    backgroundColor: infoType == SnackBarType.success
        ? IColors.successColor
        : IColors.errorColor,
    icon: infoType == SnackBarType.success
        ? const Icon(FluentIcons.braces_checkmark_16_regular)
        : const Icon(FluentIcons.braces_dismiss_16_regular),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    onTap: (snack) => Get.back(),
  );
}
