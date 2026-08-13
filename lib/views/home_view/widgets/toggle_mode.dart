import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/core/theme/icons.style.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleBtn extends StatefulWidget {
  final controller;
  const ToggleBtn({super.key, required this.controller});

  @override
  State<ToggleBtn> createState() => _ToggleBtnState();
}

class _ToggleBtnState extends State<ToggleBtn> {
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 50.0,
      minHeight: 50.0,
      initialLabelIndex: 0,
      activeBgColor: [Colors.green],
      activeFgColor: Colors.white,
      inactiveBgColor: IColors.backgroundDark,
      inactiveFgColor: IColors.backgroundLight,
      totalSwitches: 2,
      icons: [AppIcons.copy, AppIcons.move],
      onToggle: (index) {
        print('switched to: $index');
      },
    );
  }
}
