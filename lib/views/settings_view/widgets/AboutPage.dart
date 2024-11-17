import 'package:flutter/material.dart';

class AboutProjectDialog extends StatelessWidget {
  AboutProjectDialog();

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
