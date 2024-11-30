import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

enum LogLevel {
  debug(
    attentioncolor: Colors.blue,
    icon: FluentIcons.bug_24_regular,
    description: "Debug",
  ),
  info(
    attentioncolor: Colors.green,
    icon: FluentIcons.info_24_regular,
    description: "Success",
  ),
  warning(
    attentioncolor: Colors.orange,
    icon: FluentIcons.text_bullet_list_24_regular,
    description: "warning",
  ),
  error(
    attentioncolor: Colors.red,
    icon: FluentIcons.text_bullet_list_24_regular,
    description: "Error",
  ),
  copy(
    attentioncolor: Colors.green,
    icon: FluentIcons.copy_arrow_right_24_regular,
    description: "Success",
  ),
  move(
    attentioncolor: Colors.green,
    icon: FluentIcons.arrow_move_24_regular,
    description: "Success",
  ),
  duplicate(
    attentioncolor: Colors.grey,
    icon: FluentIcons.bug_24_regular,
    description: "Duplicate",
  );

  final Color attentioncolor;
  final IconData icon;
  final String description;

  const LogLevel({
    required this.attentioncolor,
    required this.icon,
    required this.description,
  });
}
