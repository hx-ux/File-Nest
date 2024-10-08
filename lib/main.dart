import 'dart:io';

import 'package:file_nest/config.dart';
import 'package:file_nest/src/core/theme/app_theme.dart';
import 'package:file_nest/src/model/db.dart';
import 'package:file_nest/src/routes/app_pages.dart';
import 'package:file_nest/src/views/bindings/binding.dart';
import 'package:file_nest/src/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';
import 'package:global_configuration/global_configuration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await DBApdater.init();
  await GlobalConfiguration().loadFromAsset("app_settings");

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: AppSettings.minSize,
    size: AppSettings.startSize,
    maximumSize: AppSettings.maxSize,
    center: false,
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
              data: (GlobalConfiguration().getValue("darkTheme"))
                  ? appThemeDataDark
                  : appThemeDataBright,
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
