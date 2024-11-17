import 'package:file_nest/model/Logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:global_configuration/global_configuration.dart';

class SETTINGS_Controller extends GetxController {
  RxInt dropdownItemsSwell = 0.obs;
  RxBool alwaysMove = false.obs;
  RxBool isDarkMode = false.obs;
  @override
  void onInit() {
    super.onInit();
    GlobalConfiguration().loadFromAsset("app_settings");
    alwaysMove.value = GlobalConfiguration().getValue("alwaysMove");
    isDarkMode.value = GlobalConfiguration().getValue("darkTheme");
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
    GlobalConfiguration().updateValue("darkTheme", _temp);

    AppLogger(
      message: "set color Theme to  $isDarkMode",
      logLevel: LogLevel.info,
    ).logToFile(showSnackbar: false);

    update();
    Navigator.of(Get.context!).pop();
  }

  void toggleCopyMove() {
    var _temp = !alwaysMove.value;
    GlobalConfiguration().updateValue("alwaysMove", _temp);
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
