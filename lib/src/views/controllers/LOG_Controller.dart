import 'package:file_nest/src/model/Logger.dart';
import 'package:get/get.dart';

class LOG_Controller extends GetxController {
  List<AppLogger> logList = [];
  @override
  void onInit() async {
    super.onInit();
    AppLogger logger =  AppLogger();
    logList = await logger.readLog();
  }
}
