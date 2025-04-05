import 'package:file_nest/config.dart';
import 'package:file_nest/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final lightTheme = appThemeDataBright;
final darkTheme = appThemeDataDark;

class ThemeController extends GetxController {
  Rx<bool> currentTheme = true.obs;

  ThemeData get getTheme => currentTheme.value ? darkTheme : lightTheme;
  
  @override
  Future<void> onInit() async {
    super.onInit();
    var themeFile = await loadSettings();
    currentTheme.value = themeFile["themeMode"] == 1 ? true : false;
  }
}
