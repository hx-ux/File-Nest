import 'package:file_nest/config.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/views/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SETTINGS_Controller extends GetxController {
  RxBool alwaysMove = false.obs;
  RxBool isDarkMode = false.obs;

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

  void toggleColorMode() {
    isDarkMode.value = !isDarkMode.value;
    var themeController = Get.put(ThemeController());
    themeController.currentTheme.value = isDarkMode.value;
    print("set color Theme to  $isDarkMode");
    AppLogger(
      message: "set color Theme to  $isDarkMode",
      logLevel: LogLevel.info,
    ).logToFile(showSnackbar: false);

    saveSettings({
      "themeMode": isDarkMode.value ? 1 : 0,
    });
  }

  void showAboutPage(BuildContext context) => showAboutPage(context);
}
