import 'package:file_nest/model/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LOG_Controller extends GetxController {
  var logList = <AppLogger>[].obs; // logList.

  @override
  void onInit() {
    // TODO: implement onInit
    loadContext();
    super.onInit();
  }

  void loadContext() async {
    await AppLogger().readLog().then((x)=> logList.value = x);
    for (var element in logList) {
      print(element.message);
    }
  }
}
