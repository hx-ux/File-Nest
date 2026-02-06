import 'package:file_nest/core/theme/icons.style.dart';
import 'package:file_nest/core/widgets/responsive_page.dart';
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
        body: ResponsivePage(
      child: Column(
        children: <Widget>[
          const Navbar(
            subpage: true,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                controller.sortbyDateDesc.value =
                    !controller.sortbyDateDesc.value;
                controller.sortLogs();
              },
              icon: Obx(() => Icon(
                    controller.sortbyDateDesc.value
                        ? AppIcons.arrowUp
                        : AppIcons.arrowDown,
                  )),
              label: const Text("Sort by Date"),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                itemCount: controller.logList.length,
                itemBuilder: (BuildContext context, int index) {
                  return LoggerCard(logger: controller.logList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
