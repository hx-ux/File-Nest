import 'package:file_nest/src/core/theme/colors.style.dart';
import 'package:file_nest/src/views/controllers/HOME_Controller.dart';
import 'package:file_nest/src/views/home_view/widgets/ToggleButton.dart';
import 'package:file_nest/src/views/logs_view/logs_view.dart';
import 'package:file_nest/src/views/settings_view/settings_view.dart';
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
                  Icon(Icons.backspace_outlined),
                  Text('History'),
                ],
              ),
            ),
          if (!subpage)
            ElevatedButton(
              onPressed: () {
                Get.to(Logs_Page());
              },
              child: const Column(
                children: [
                  Icon(Icons.history),
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
                  Icon(Icons.settings),
                  Text('Config'),
                ],
              ),
            ),
          if (!subpage)
          // controller.changeMode(idx);
          
           ToggleBtn(controller: controller)
               
            // FkToggle(
            //   width: 50,
            //   height: 50,
            //   labels: const ['copy', 'move'],
            //   backgroundColor: IColors.background,
            //   selectedColor: IColors.attentionColor,
            //   enabledElementColor: Colors.white,
            //   disabledElementColor: Colors.white,
            //   onSelected: (idx, instance) {
            //     controller.changeMode(idx);
            //   },
            // ),
        ],
      ),
    );
  }
}
