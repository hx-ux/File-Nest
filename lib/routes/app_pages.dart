import 'package:file_nest/views/file_operations_view/file_operations_view.dart';
import 'package:file_nest/views/home_view/home_view.dart';
import 'package:file_nest/views/logs_view/logs_view.dart';
import 'package:file_nest/views/settings_view/settings_view.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => Home_Page(),
    ),
    GetPage(name: Routes.settings, page: () => SettingsPage()),
    GetPage(name: Routes.log, page: () => LogsPage()),
    GetPage(name: Routes.fileOperation, page: () => FileTransferView()),
  ];
}
