import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/core/theme/fonts.style.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:file_nest/views/home_view/widgets/addBtn.dart';
import 'package:file_nest/views/home_view/widgets/card_list.dart';
import 'package:file_nest/views/home_view/widgets/navbar.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class Home_Page extends GetView<HOME_Controller> {
  @override
  final controller = Get.put(HOME_Controller());

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
        controller.allArtefacts.isEmpty
            ? const Expanded(child: Center(child: Text("add folders")))
            : Expanded(
                child: ListView(
                  shrinkWrap: true, // use it
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

