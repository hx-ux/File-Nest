import 'package:file_nest/src/model/db.dart';
import 'package:file_nest/src/routes/app_pages.dart';
import 'package:file_nest/src/views/bindings/binding.dart';
import 'package:file_nest/src/views/controllers/HOME_Controller.dart';
import 'package:file_nest/src/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';

final controller = Get.put(HOME_Controller());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await DBApdater.init();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(400, 400),
    size: Size(400, 800),
    center: false,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
    title: "File nest",
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
              data: controller.themeData,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ),
            );
          },
          initialRoute: Routes.SETTINGS,
          getPages: AppPages.pages,
          home: Controll(), // app screens
        );
      },
    ),
  );
}
