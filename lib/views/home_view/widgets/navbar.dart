
import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:file_nest/views/home_view/widgets/ToggleButton.dart';
import 'package:file_nest/views/logs_view/logs_view.dart';
import 'package:file_nest/views/settings_view/settings_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Navbar extends GetView<HOME_Controller> {
  final subpage;
  const Navbar({Key? key, required this.subpage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: IColors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (subpage)
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Column(
                children: [
                  Icon(FluentIcons.backspace_24_regular),
                  Text('Back'),
                ],
              ),
            ),
          if (!subpage)
            ElevatedButton(
              onPressed: () {
                Get.to(LogsPage());
              },
              child: const Column(
                children: [
                  Icon(FluentIcons.history_24_regular),
                  Text('History'),
                ],
              ),
            ),
          if (!subpage)
            ElevatedButton(
              onPressed: () {
                Get.to( SettingsPage());
              },
              child: const Column(
                children: [
                  Icon(FluentIcons.settings_24_regular),
                  Text('Config'),
                ],
              ),
            ),
          if (!subpage)
           ToggleBtn(controller: controller)
        ],
      ),
    );
  }
}
