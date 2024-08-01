import 'package:file_nest/src/views/controllers/HOME_Controller.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class AddBtn extends StatelessWidget {
  const AddBtn({
    super.key,
    required this.controller,
  });

  final HOME_Controller controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          controller.addArtefact();
          
        },
        child: const Icon(FluentIcons.add_24_regular),
      );
  }
}
