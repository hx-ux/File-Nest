import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LOG_Controller extends GetxController {
  var logList = <AppLogger>[].obs;

  RxBool sortbyDateDesc = true.obs;


  @override
  void onInit() {
    loadContext();
    super.onInit();
  }

  void loadContext() async {
    var logs = await AppLogger().readLog();
    logList.value = logs;
  }

  void sortLogs() {
    if (sortbyDateDesc.value) {
      logList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    } else {
      logList.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
    }
  }
}
