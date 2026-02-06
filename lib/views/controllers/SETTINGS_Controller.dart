import 'package:file_nest/config.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/views/controllers/theme_controller.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
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

  Future<void> toggleColorMode() async {
    isDarkMode.value = !isDarkMode.value;
    var themeController = Get.put(ThemeController());
    await themeController.setThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
    AppLogger(
      message: "set color Theme to ${isDarkMode.value}",
      logLevel: LogLevel.info,
    ).logToFile(showSnackbar: false);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    isDarkMode.value = mode == ThemeMode.dark;
    var themeController = Get.put(ThemeController());
    await themeController.setThemeMode(mode);
  }
}
