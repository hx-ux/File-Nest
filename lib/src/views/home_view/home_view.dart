import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_nest/src/model/TargetArtefact.dart';
import 'package:file_nest/src/views/controllers/HOME_Controller.dart';
import 'package:file_nest/src/views/home_view/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// ignore: use_key_in_widget_constructors
class Controll extends GetView<HOME_Controller> {
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
        ListView(
            shrinkWrap: true, // use it
            children: [
               Obx(
          () =>
              ListView.builder(
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
              )
               )
            ],
        ),
        FloatingActionButton(
          onPressed: () async {
            controller.addArtefact();
          },
          child: const Icon(Icons.add),
        ),
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
        print("enter {id}");
        controller.selectedNode = widget.artefact;
        controller.isOverNode.value = true;
        controller.dropTragetIdentifier.value = widget.DropTragetIdentifier;
        print("over node: ${controller.isOverNode.value} file ${widget.artefact.url} index ${widget.DropTragetIdentifier}");
      },
      onDragExited: (detail) {
        print("exit");
        controller.selectedNode = TargetArtefact("", "");
        controller.isOverNode.value = false;
      },
      child: Obx(() => Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: controller.isOverNode.value &&
                      controller.dropTragetIdentifier.value ==
                          widget.DropTragetIdentifier
                  ? Colors.blue
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 13,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.openFileExplorer((widget.artefact.url));
                    },
                    icon: const Icon(Icons.folder_open)),
                IconButton(
                    onPressed: () {controller.deleteArtefact(widget.artefact);}, icon: const Icon(Icons.delete_forever)),
                Container(
                  child: Center(
                    child: Text(widget.artefact.name.toString()),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
