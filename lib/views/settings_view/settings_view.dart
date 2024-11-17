
import 'package:file_nest/views/controllers/SETTINGS_Controller.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';
import 'package:file_nest/views/settings_view/widgets/AboutPage.dart';
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
      children: <Widget>[
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
            },
            child: const Text("Clear database"),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AboutProjectDialog();
                },
              );
            },
            child: const Text("About"),
          ),
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.1,
        //   width: MediaQuery.of(context).size.width * 0.6,
        //   child: Row(
        //     children: [
        //       const Text(
        //         'Always Move',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Obx(() => Checkbox(
        //             value: controller.alwaysMove.value,
        //             onChanged: (bool? value) {
        //               controller.setDefaultCopyMove(value!);
        //             },
        //           ))
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.1,
        //   width: MediaQuery.of(context).size.width * 0.6,
        
        //   child: Row(
        //     children: [
        //       const Text(
        //         'Dark Mode',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //       Obx(() => Checkbox(
        //             value: controller.isDarkMode.value,
        //             onChanged: (bool? value) {
        //               controller.toggleColorMode(value!);
        //             },
        //           ))
        //     ],
        //   ),
        // ),
      ],
    ));
  }
}
