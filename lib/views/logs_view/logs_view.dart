import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/views/controllers/LOG_Controller.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';
import 'package:file_nest/views/logs_view/widget/log_card.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogsPage extends GetView<LOG_Controller> {
  @override
  final controller = Get.put(LOG_Controller());

  get onChanged => null;

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
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        controller.sortbyDateDesc.value =
                            !controller.sortbyDateDesc.value;
                        controller.sortLogs();
                      },
                      child: Row(
                        children: [
                          Text("Sort by Date",
                              style: TextStyle(color: Colors.white)),
                          Obx(() => Icon(
                              controller.sortbyDateDesc.value
                                  ? FluentIcons.arrow_up_12_filled
                                  : FluentIcons.arrow_down_12_filled,
                              color: Colors.white)),
                        ],
                      )),
                ],
              ),
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
