import 'package:file_nest/core/widgets/responsive_page.dart';
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
        body: ResponsivePage(
      child: Column(
        children: <Widget>[
          const Navbar(
            subpage: false,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Obx(
              () => controller.allArtefacts.isEmpty
                  ? Center(
                      child: Text(
                        "Add folders to get started",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: controller.allArtefacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ArtefactListEntry(
                            artefact: controller.allArtefacts[index],
                            controller: controller,
                            DropTragetIdentifier: index,
                          ),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 12),
          AddBtn(controller: controller),
        ],
      ),
    ));
  }
}
