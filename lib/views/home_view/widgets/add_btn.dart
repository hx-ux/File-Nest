import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:file_nest/core/theme/icons.style.dart';
import 'package:flutter/material.dart';

class AddBtn extends StatelessWidget {
  const AddBtn({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          controller.addArtefact();
          
        },
        child: const Icon(AppIcons.add),
      );
  }
}
