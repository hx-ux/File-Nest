import 'package:file_nest/src/views/controllers/LOG_Controller.dart';
import 'package:file_nest/src/views/home_view/widgets/navbar.dart';
import 'package:file_nest/src/views/logs_view/widget/log_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogsPage extends GetView<LOG_Controller> {
  LogsPage({super.key});
  @override
  final controller = Get.put(LOG_Controller());

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

         Expanded (
          child: 
        ListView(
          shrinkWrap: true, // use it
          physics: ClampingScrollPhysics(),
          children: [
            controller.logList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true, // use it
                    padding: const EdgeInsets.all(8),
                    physics: ClampingScrollPhysics(),
                    itemCount: controller.logList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardExample.LogCard(
                        message: controller.logList[index].message,
                        time: controller.logList[index].timestamp.toString(),
                        icon: controller.logList[index].icon!,
                        color: controller.logList[index].col!,
                        filename: controller.logList[index].fileName,
                      );
                    })
                : const Text("no data found"),
          ],
        ),
         ),

     
      ],
    ));
  }
}
