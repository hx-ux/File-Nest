import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/core/theme/fonts.style.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';

class ArtefactListEntry extends StatefulWidget {
  final HOME_Controller controller;
  final TargetArtefact artefact;
  final DropTragetIdentifier;
  ArtefactListEntry({
    super.key,
    required this.controller,
    required this.artefact,
    required this.DropTragetIdentifier,
  });

  final showInfo = false.obs;
  @override
  State<ArtefactListEntry> createState() => _ArtefactListEntryState();
}

class _ArtefactListEntryState extends State<ArtefactListEntry> {
  late final HOME_Controller controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HOME_Controller>();
  }

  @override
  Widget build(BuildContext context) {

    return DropTarget(
      onDragDone: (detail) {
        controller.selectedNode = TargetArtefact("", "");
        controller.isOverNode = false.obs;

        List<String> files = [];
        detail.files.forEach((file) => files.add(file.path));
        controller.fileTransferOperation(files, (widget.artefact.url));
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
          child: controller.isOverNode.value &&
                  controller.dropTragetIdentifier.value ==
                      widget.DropTragetIdentifier
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center, // add space
                  children: [
                    Text(
                      "Copy files to ${widget.artefact.name}",
                      style: const TextStyle(
                        color: IColors.iconsColorArteFacts,
                        fontFamily: IFont.primaryFontBold,
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start, // add space
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.showInfo.value = !widget.showInfo.value;
                      },
                      icon: const Icon(FluentIcons.info_24_regular),
                      color: IColors.iconsColorArteFacts,
                    ),
                    if (!widget.showInfo.value)
                      IconButton(
                        onPressed: () {
                          controller.openFileExplorer((widget.artefact.url));
                        },
                        icon:
                            const Icon(FluentIcons.document_folder_24_regular),
                        color: IColors.iconsColorArteFacts,
                      ),
                    if (!widget.showInfo.value)
                      IconButton(
                        onPressed: () {
                          controller.deleteArtefact(widget.artefact);
                        },
                        icon: const Icon(FluentIcons.bin_recycle_24_regular),
                        color: IColors.iconsColorArteFacts,
                      ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Center(
                      child: Text(
                        widget.showInfo.value
                            ? widget.artefact.url.toString()
                            : widget.artefact.name.toString(),
                        style: const TextStyle(
                          color: IColors.iconsColorArteFacts,
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
