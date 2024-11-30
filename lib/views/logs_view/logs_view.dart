import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/views/controllers/LOG_Controller.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';
import 'package:file_nest/views/logs_view/widget/log_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogsPage extends GetView<LOG_Controller> {
  @override
  final controller = Get.put(LOG_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Navbar(
            subpage: true,
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true, // use it
            physics: ClampingScrollPhysics(),
            children: [
              Obx(() => ListView.builder(
                  shrinkWrap: true, // use it
                  padding: const EdgeInsets.all(8),
                  physics: ClampingScrollPhysics(),
                  itemCount: controller.logList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LoggerCard(logger: controller.logList[index]);
                  }))
            ],
          ),
        ),
      ],
    ));
  }
}
