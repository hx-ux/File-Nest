import 'package:file_nest/config.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/views/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;
  var themeController = Get.put(ThemeController());
  @override
  Future<void> onInit() async {
    super.onInit();
    final settings = await loadSettings();
    isDarkMode.value = settings["themeMode"] == 1 ? true : false;
  }

  void clearDataBase() {
    AppLogger.clearLogFile();
    AppLogger(
      message: "Cleared Database not yet implemented",
      logLevel: LogLevel.error,
    ).logToFile();
  }

  void clearLogs() {
    AppLogger.clearLogFile();
    AppLogger(
      message: "Cleared Logfile",
      logLevel: LogLevel.info,
    ).logToFile();
  }

  ThemeMode getThemeMode() => themeController.currentMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    await themeController.setThemeMode(mode);
  }
}
