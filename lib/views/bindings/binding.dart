import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:file_nest/views/controllers/LOG_Controller.dart';
import 'package:file_nest/views/controllers/SETTINGS_Controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

class ControllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogController>(
      () => LogController(),
    );
  }
}

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
