import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/core/theme/icons.style.dart';
import 'package:flutter/material.dart';

enum LogLevel {
  debug(
    attentioncolor: IColors.primary,
    icon: AppIcons.bug,
    description: "Debug",
  ),
  info(
    attentioncolor: IColors.successColor,
    icon: AppIcons.info,
    description: "Success",
  ),
  warning(
    attentioncolor: Color(0xFFF59E0B),
    icon: AppIcons.list,
    description: "warning",
  ),
  error(
    attentioncolor: IColors.errorColor,
    icon: AppIcons.list,
    description: "Error",
  ),
  copy(
    attentioncolor: IColors.successColor,
    icon: AppIcons.copyArrowRight,
    description: "Success",
  ),
  move(
    attentioncolor: IColors.successColor,
    icon: AppIcons.moveArrow,
    description: "Success",
  ),
  duplicate(
    attentioncolor: Color(0xFF94A3B8),
    icon: AppIcons.bug,
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
