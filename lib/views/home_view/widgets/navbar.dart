import 'package:file_nest/core/theme/icons.style.dart';
import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:file_nest/views/home_view/widgets/toggle_mode.dart';
import 'package:file_nest/views/logs_view/logs_view.dart';
import 'package:file_nest/views/settings_view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_nest/core/theme/icons.style.dart';

class Navbar extends GetView<HomeController> {
  final bool subpage;
  const Navbar({Key? key, required this.subpage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0),
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
                  Icon(AppIcons.back),
                  Text('Back'),
                ],
              ),
            ),
          if (!subpage)
            ElevatedButton(
              onPressed: () {
                Get.to(() => LogsPage());
              },
              child: const Column(
                children: [
                  Icon(AppIcons.history),
                  Text('History'),
                ],
              ),
            ),
          if (!subpage)
            ElevatedButton(
              onPressed: () {
                Get.to(() => SettingsPage());
              },
              child: const Column(
                children: [
                  Icon(
                    AppIcons.settings,
                  ),
                  Text('Config'),
                ],
              ),
            ),
          if (!subpage) ToggleBtn(controller: controller)
        ],
      ),
    );
  }
}
