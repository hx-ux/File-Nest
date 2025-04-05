import 'package:file_nest/config.dart';
import 'package:file_nest/core/utilities/UrlLauncher.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/views/controllers/SETTINGS_Controller.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SETTINGS_Controller> {
  SettingsPage({super.key});
  @override
  final controller = Get.put(SETTINGS_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Navbar(
            subpage: true,
          ),
        ),
        settingsEntry(FluentIcons.delete_12_regular, context, "Clear logs", () {
          controller.clearLogs();
        }),
        settingsEntry(FluentIcons.delete_12_regular, context, "Clear database",
            () {
          controller.clearDataBase();
        }),
        settingsEntry(
            FluentIcons.book_arrow_clockwise_20_regular, context, "Github", () {
          UrlLaunchOptions.launchInBrowser(
              "https://github.com/hx-ux/File-Nest");
        }),
        settingsEntry(
            FluentIcons.settings_16_filled, context, "Open settings folder",
            () {
          UrlLaunchOptions.openInFileExplorer(
              getLogFilePath().then((value) => value.parent.path) as String);
        }),
        Obx(
          () => settingsEntry(
            FluentIcons.dark_theme_20_filled,
            context,
            controller.isDarkMode.value ? "Dark Mode" : "Light Mode",
            () {
              controller.toggleColorMode();
            },
          ),
        ),
        settingsEntry(
          FluentIcons.info_12_filled,
          context,
          "${AppSettings.appVersion} ${AppSettings.currPlatform}",
          () {},
        ),
      ],
    ));
  }

  SizedBox settingsEntry(IconData leading, BuildContext context, String desc,
      void Function() action,
      {bool hasInfoIcon = false, bool infoIconState = false}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        children: [
          Icon(
            leading,
          ),
          ElevatedButton(
            onPressed: () => action(),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(desc),
            ),
          ),
          if (hasInfoIcon)
            Icon(
              infoIconState
                  ? FluentIcons.select_object_skew_20_filled
                  : FluentIcons.send_16_filled,
              color: infoIconState ? Colors.green : Colors.red,
            )
        ],
      ),
    );
  }
}
