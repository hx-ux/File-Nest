import 'package:file_nest/config.dart';
import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/core/theme/icons.style.dart';
import 'package:file_nest/core/widgets/responsive_page.dart';
import 'package:file_nest/core/utilities/UrlLauncher.dart';
import 'package:file_nest/views/controllers/SETTINGS_Controller.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsPage extends GetView<SettingsController> {
  SettingsPage({super.key});
  @override
  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsivePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Navbar(subpage: true),
          const SizedBox(height: 12),
          Text(
            "Settings",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(AppIcons.darkMode),
                        title: const Text("Theme"),
                        trailing: ToggleSwitch(
                          minWidth: 50.0,
                          minHeight: 30.0,
                          initialLabelIndex: controller.getThemeMode().index,
                          activeBgColor: [Colors.green],
                          activeFgColor: Colors.white,
                          inactiveBgColor: IColors.backgroundDark,
                          inactiveFgColor: IColors.backgroundLight,
                          totalSwitches: 3,
                          icons: [
                            AppIcons.followSystsem,
                            AppIcons.lightMode,
                            AppIcons.darkMode
                          ],
                          onToggle: (index) {
                            var t = ThemeMode.values[index ?? 0];
                            controller.setThemeMode(t);
                            print('switched to: $t');
                          },
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(AppIcons.openFolder),
                        title: const Text("Open settings folder"),
                        subtitle: const Text("Logs and local configuration"),
                        onTap: () async {
                          final path = await getLogFilePath();
                          UrlLaunchOptions.openInFileExplorer(path.parent.path);
                          return;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(AppIcons.delete),
                        title: const Text("Clear logs"),
                        subtitle: const Text("Remove all log entries"),
                        onTap: () => controller.clearLogs(),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(AppIcons.delete),
                        title: const Text("Clear database"),
                        subtitle: const Text("Reset the local database"),
                        onTap: () => controller.clearDataBase(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(AppIcons.github),
                        title: const Text("GitHub"),
                        onTap: () {
                          UrlLaunchOptions.launchInBrowser(
                              "https://github.com/hx-ux/File-Nest");
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(AppIcons.info),
                        title: const Text("Version"),
                        subtitle: Text(
                            "${AppSettings.appVersion} ${AppSettings.currPlatform}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
