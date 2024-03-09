import 'package:file_nest/src/views/controllers/LOG_Controller.dart';
import 'package:file_nest/src/views/home_view/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logs_view extends GetView<LOG_Controller> {
  @override
  final controller = Get.put(LOG_Controller());

  Logs_view({super.key});
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
        ListView(
          shrinkWrap: true, // use it
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.logList.length,
              itemBuilder: (BuildContext context, int index) {
                if (controller.logList.isEmpty) {
                  return const Text("No Logs");
                } else {
                  return ListView.builder(
                    itemCount: controller.logList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Return a widget for the item at the specified index
                      return Text(controller.logList[index].message);
                    },
                  );
                }
              },
            )
          ],
        ),
      ],
    ));
  }
}
