import 'dart:io';

import 'package:file_nest/config.dart';
import 'package:file_nest/core/theme/app_theme.dart';
import 'package:file_nest/model/db.dart';
import 'package:file_nest/routes/app_pages.dart';
import 'package:file_nest/views/bindings/binding.dart';
import 'package:file_nest/views/home_view/home_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await DBApdater.init();

  await initializeDateFormatting('de_DE', null);
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: AppSettings.minSize,
    size: AppSettings.startSize,
    maximumSize: AppSettings.maxSize,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
    title: AppSettings.appName,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    ScreenUtilInit(
      builder: (context, widget) {
        return GetMaterialApp(
          useInheritedMediaQuery: false,
          debugShowCheckedModeBanner: false,
          initialBinding: HomeBindings(),
          builder: (context, widget) {
            return Theme(
              data: appThemeDataDark,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ),
            );
          },
          initialRoute: Routes.HOME,
          getPages: AppPages.pages,
          home: Home_Page(), // app screens
        );
      },
    ),
  );
}
