import 'package:file_nest/src/views/logs_view/logs_view.dart';
import 'package:file_nest/src/views/settings_view/settings_view.dart';
import 'package:get/get.dart';
import 'package:file_nest/src/views/home_view/home_view.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME,page: () => Home_Page(),),
    GetPage(name: Routes.SETTINGS, page: () => SettingsPage()),
    GetPage(name: Routes.LOG, page: () => LogsPage()),
  ];
}
