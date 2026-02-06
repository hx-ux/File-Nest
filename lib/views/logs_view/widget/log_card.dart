import 'package:file_nest/model/Logger.dart';
import 'package:file_nest/model/log_level.dart';
import 'package:file_nest/core/theme/icons.style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoggerCard extends StatelessWidget {
  LoggerCard({super.key, required this.logger});
  final AppLogger logger;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          context.width * 0.01, context.height * 0.01, context.width * 0.01, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: logger.color ?? colorScheme.primary),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(logger.icon ?? AppIcons.info,
                  color: colorScheme.onPrimary),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                singleLine(context, logger.message, isHeadline: true),
                if (logger.logLevel == LogLevel.copy ||
                    logger.logLevel == LogLevel.move)
                  singleLine(context, logger.fileName.toString()),
                if (logger.logLevel == LogLevel.copy ||
                    logger.logLevel == LogLevel.move)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(AppIcons.arrowDown, color: Colors.white, size: 15),
                  ],
                ),
                if (logger.logLevel == LogLevel.copy ||
                    logger.logLevel == LogLevel.move)
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
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: isHeadline ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
