import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType {
  success,
  error,
  copy,
}

SnackbarController showSnackbarInformations(String message,
    {infoType = SnackBarType.success}) {
  return Get.snackbar(
    infoType == SnackBarType.success ? "success" : "Error",
    message,
    colorText: Colors.white,
    backgroundColor:
        infoType == SnackBarType.success ? Colors.green : Colors.red,
    icon: infoType == SnackBarType.success
        ? const Icon(Icons.check)
        : const Icon(Icons.add_alert),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    
  );
}
