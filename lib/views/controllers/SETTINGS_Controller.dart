import 'package:file_nest/config.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SETTINGS_Controller extends GetxController {
  RxInt dropdownItemsSwell = 0.obs;
  RxBool alwaysMove = false.obs;
  RxBool isDarkMode = false.obs;
  @override
  void onInit() {
    super.onInit();
    alwaysMove.value = AppSettings.getSettingsByKey("move") as bool;
    isDarkMode.value = AppSettings.getSettingsByKey("theme") as bool;
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
      message: "Cleared  Logfile",
      logLevel: LogLevel.info,
    ).logToFile();
  }

  void toggleColorMode() {
    var _temp = !isDarkMode.value;
    isDarkMode.value = _temp;
    AppSettings.setSettingsByKey("theme", null);
    AppLogger(
      message: "set color Theme to  $isDarkMode",
      logLevel: LogLevel.info,
    ).logToFile(showSnackbar: false);

    update();
    Navigator.of(Get.context!).pop();
  }

  void toggleCopyMove() {
    var _temp = !alwaysMove.value;
    AppSettings.setSettingsByKey("move", null);
    alwaysMove.value = _temp;
    AppLogger(
      message: "changed default mode to $_temp",
      logLevel: LogLevel.info,
    ).logToFile(showSnackbar: false);
    update();
    Navigator.of(Get.context!).pop();
  }

  void showAboutPage(BuildContext context) => showAboutPage(context);
}
