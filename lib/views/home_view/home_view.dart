import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:file_nest/views/home_view/widgets/add_btn.dart';
import 'package:file_nest/views/home_view/widgets/card_list.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class Home_Page extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Navbar(
            subpage: false,
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.allArtefacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ArtefactListEntry(
                          artefact: controller.allArtefacts[index],
                          controller: controller,
                          DropTragetIdentifier: index,
                        ),
                      );
                    },
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddBtn(controller: controller),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
          width: MediaQuery.of(context).size.width,
        )
      ],
    ));
  }
}
