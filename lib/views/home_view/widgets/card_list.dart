import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_nest/core/theme/icons.style.dart';
import 'package:file_nest/core/utilities/UrlLauncher.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtefactListEntry extends StatefulWidget {
  final HomeController controller;
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
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
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

  Obx EntryCard(BuildContext context, HomeController controller) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Obx(() => Container(
          constraints: const BoxConstraints(minHeight: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: controller.isOverNode.value &&
                    controller.dropTragetIdentifier.value ==
                        widget.DropTragetIdentifier
                ? colorScheme.primaryContainer
                : colorScheme.surface,
            border: Border.all(color: colorScheme.outline),
          ),
          child: controller.isOverNode.value &&
                  controller.dropTragetIdentifier.value ==
                      widget.DropTragetIdentifier
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center, // add space
                  children: [
                    Text(
                      "Copy files to ${widget.artefact.name}",
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
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
                      icon: const Icon(AppIcons.info),
                      color: colorScheme.onSurface,
                    ),
                    if (!widget.showInfo.value)
                      IconButton(
                        onPressed: () {
                          UrlLaunchOptions.openInFileExplorer(
                              (widget.artefact.url));
                        },
                        icon: const Icon(AppIcons.folder),
                        color: colorScheme.onSurface,
                      ),
                    if (!widget.showInfo.value)
                      IconButton(
                        onPressed: () {
                          controller.deleteArtefact(widget.artefact);
                        },
                        icon: const Icon(AppIcons.delete),
                        color: colorScheme.onSurface,
                      ),
                    const SizedBox(width: 16),
                    Center(
                      child: Text(
                        widget.showInfo.value
                            ? widget.artefact.url.toString()
                            : widget.artefact.name.toString(),
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
