import 'package:file_nest/model/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LOG_Controller extends GetxController {
  var logList = <AppLogger>[].obs;

  @override
  void onInit() {
    loadContext();
    super.onInit();
  }

  void loadContext() async {
    var logs = await AppLogger().readLog();
    logList.value = logs;
    for (var element in logs) {
      debugPrint(element.message);
    }
  }
}
