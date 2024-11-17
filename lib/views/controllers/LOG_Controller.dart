import 'package:file_nest/model/Logger.dart';
import 'package:get/get.dart';

class LOG_Controller extends GetxController {
  List<AppLogger> logList = [];
  List<String> logListString = [];
  @override
  void onInit() async {
    super.onInit();
    AppLogger logger =  AppLogger();
    logList = await logger.readLog();
  }
}
