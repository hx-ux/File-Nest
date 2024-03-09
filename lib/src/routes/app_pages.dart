import 'package:file_nest/src/views/settings_view/settings_page.dart';
import 'package:get/get.dart';
import 'package:file_nest/src/views/home_view/home_view.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const SettingsPage(),
    ),
    GetPage
      (name: Routes.SETTINGS, 
      page: () => Controll())
  ];
}
