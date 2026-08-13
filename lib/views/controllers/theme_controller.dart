import 'package:file_nest/config.dart';
import 'package:file_nest/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final lightTheme = appThemeDataBright;
final darkTheme = appThemeDataDark;

class ThemeController extends GetxController {

  Rx<ThemeMode> themeMode = ThemeMode.dark.obs;
  
  ThemeMode get currentMode => themeMode.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    var themeFile = await loadSettings();
    themeMode.value =
        themeFile["themeMode"] == 1 ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    await saveSettings({"themeMode": mode == ThemeMode.dark ? 1 : 0});
  }
}
