import 'package:file_nest/config.dart';
import 'package:flutter/material.dart';

import 'package:file_nest/src/views/controllers/SETTINGS_Controller.dart';
import 'package:file_nest/src/views/home_view/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class AboutProjectDialog extends StatelessWidget {

  AboutProjectDialog(
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('File Nest'),
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Description:'),
          Text('Link:'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

