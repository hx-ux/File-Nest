import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class File_Operation_Page extends GetView<HOME_Controller> {
  @override
  final controller = Get.put(HOME_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Obx(
          () => controller.currentFileProcessFinished.value
              ? SizedBox(
                  child: const Text("Finsihed",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                )
              : Column(
                  children: [
                    Center(
                      child: Text(
                          "copy${controller.currentProcressedFile.value.split('/').last}",
                          style:
                              const TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    LinearProgressIndicator(
                        value: (controller.transferProgress.value)),
                    Text(
                      "${((controller.transferProgress.value * 100).roundToDouble()).clamp(0, 100).toInt()}%",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
        )
      ],
    ));
  }
}
