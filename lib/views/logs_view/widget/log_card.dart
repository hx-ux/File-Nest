import 'package:file_nest/model/Logger.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class LoggerCard extends StatelessWidget {
  LoggerCard({super.key, required this.logger});
  final AppLogger logger;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: logger.color ?? Colors.blue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(logger.icon ?? FluentIcons.info_24_regular),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(logger.message, style: TextStyle(fontSize: 14)),
                  Text(logger.timestamp.toString(),
                      style: TextStyle(fontSize: 12)),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(logger.fileName,
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
