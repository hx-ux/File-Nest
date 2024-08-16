import 'package:file_nest/src/model/Logger.dart';
import 'package:file_nest/src/services/snackbar_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void toggleColorMode(bool selValue) {
    isDarkMode.value =  selValue;
    print("set color Theme to  ${isDarkMode.value}"); 
    GlobalConfiguration().updateValue("darkTheme", selValue);
    AppLogger(
      message: "set color Theme to  $isDarkMode",
      logLevel: LogLevel.info,
    ).logToFile(showSnackbar: false);
    update();
    // print("set color Theme to  $isDarkMode"); 
  }

  void setDefaultCopyMove(bool selValue) {
    GlobalConfiguration().updateValue("alwaysMove", selValue);
    alwaysMove.value = selValue;
    AppLogger(
      message: "changed default mode to $selValue",
      logLevel: LogLevel.info,
    ).logToFile(showSnackbar: false);
    update();
  }

  void showAboutPage(BuildContext context) {
    showAboutPage(context);
  }
}
