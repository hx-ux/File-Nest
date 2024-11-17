import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/core/theme/fonts.style.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:file_nest/views/home_view/widgets/addBtn.dart';
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

class ArtefactListEntry extends StatefulWidget {
  final HOME_Controller controller;
  final TargetArtefact artefact;
  final DropTragetIdentifier;
  const ArtefactListEntry({
    super.key,
    required this.controller,
    required this.artefact,
    required this.DropTragetIdentifier,
  });

  @override
  State<ArtefactListEntry> createState() => _ArtefactListEntryState();
}

class _ArtefactListEntryState extends State<ArtefactListEntry> {
  @override
  Widget build(BuildContext context) {
    HOME_Controller controller = Get.find<HOME_Controller>();

    return DropTarget(
      onDragDone: (detail) {
        controller.selectedNode = TargetArtefact("", "");
        controller.isOverNode = false.obs;
        controller.moveOrCopyFile(
            File((detail.files.first).path), (widget.artefact.url));
      },
      onDragEntered: (detail) {
        controller.selectedNode = widget.artefact;
        controller.isOverNode.value = true;
        controller.dropTragetIdentifier.value = widget.DropTragetIdentifier;
      },
      onDragExited: (detail) {
        controller.selectedNode = TargetArtefact("", "");
        controller.isOverNode.value = false;
      },
      child: EntryCard(context, controller),
    );
  }

  Obx EntryCard(BuildContext context, HOME_Controller controller) {
    return Obx(() => Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: controller.isOverNode.value &&
                    controller.dropTragetIdentifier.value ==
                        widget.DropTragetIdentifier
                ? IColors.attentionColor
                : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // add space
            children: [
              IconButton(
                onPressed: () {
                  controller.openFileExplorer((widget.artefact.url));
                },
                icon: const Icon(FluentIcons.document_folder_24_regular),
              ),
              IconButton(
                onPressed: () {
                  controller.deleteArtefact(widget.artefact);
                },
                icon: const Icon(FluentIcons.bin_recycle_24_regular),
              ),
              Center(
                child: Text(
                  widget.artefact.name.toString(),
                  style: const TextStyle(
                    color: IColors.backgroundDark,
                    fontFamily: IFont.primaryFontBold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
