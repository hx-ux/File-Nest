import 'package:file_nest/config.dart';
import 'package:file_nest/core/utilities/UrlLauncher.dart';
import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/views/controllers/SETTINGS_Controller.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Navbar(
            subpage: true,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              controller.clearLogs();
            },
            child: const Text("Clear logs"),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              controller.clearDataBase();
              AppLogger(
                      logLevel: LogLevel.error,
                      message: "Clear Database- not yet implemented",	
                      fileName: "")
                  .logToFile();
            },
            child: const Text("Clear database"),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              UrlLaunchOptions.launchInBrowser(
                  "https://github.com/hx-ux/File-Nest");
            },
            child: const Text("Github"),
          ),
        ),
    
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              controller.toggleColorMode();
            },
            child: Obx(() => Text(
                  'Dark Mode ${controller.isDarkMode.value ? "✔" : "✘"}',
                )),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              controller.toggleCopyMove();
            },
            child: Obx(() => Text(
                  'Always move ${controller.alwaysMove.value ? "✔" : "✘"}',
                )),
          ),
        ),

            SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("${AppSettings.appVersion}\n${AppSettings.currPlatform}",
           style: TextStyle(color: Colors.grey),),
         ])
        ),
      ],
    ));
  }
}
