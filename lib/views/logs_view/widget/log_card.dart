import 'package:file_nest/model/Logger.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoggerCard extends StatelessWidget {
  LoggerCard({super.key, required this.logger});
  final AppLogger logger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          context.width * 0.01, context.height * 0.01, context.width * 0.01, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: logger.color ?? Colors.blue),
        child: Row(
          children: [
            Icon(logger.icon ?? FluentIcons.info_24_regular),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                singleLine(context, logger.message, isHeadline: true),
                singleLine(context, logger.fileName),
                singleLine(context, logger.timestamp.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox singleLine(BuildContext context, String? value,
      {bool isHeadline = false}) {
    return SizedBox(
      width: context.width * 0.8,
      child: Text(
        value ?? "no data",
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(
            color: Colors.white,
            fontWeight: isHeadline ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
