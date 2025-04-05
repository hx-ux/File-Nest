import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
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
                if(logger.logLevel == LogLevel.copy || logger.logLevel == LogLevel.move) singleLine(context, logger.fileName.toString()),
                if(logger.logLevel == LogLevel.copy || logger.logLevel == LogLevel.move)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(FluentIcons.arrow_down_12_filled, color: Colors.white, size: 15),
                  ],
                ),
                if(logger.logLevel == LogLevel.copy || logger.logLevel == LogLevel.move)
                singleLine(context, logger.destination.toString()),
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
        value ?? "none",
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
