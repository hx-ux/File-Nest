import 'package:file_nest/core/theme/colors.style.dart';
import 'package:file_nest/core/theme/fonts.style.dart';
import 'package:file_nest/main.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

List<String> _desc = const [
  "Copy",
  "Move",
];

List<IconData?> _icons = [
  FluentIcons.copy_24_regular,
  FluentIcons.mail_inbox_24_filled,
];

class ToggleBtn extends StatefulWidget {
  final    controller;
  const ToggleBtn({super.key, required this.controller});

  @override
  State<ToggleBtn> createState() => _ToggleBtnState();
}

class _ToggleBtnState extends State<ToggleBtn> {
  @override
  Widget build(BuildContext context) {
    late int selItem = widget.controller.copyOrMove.value.index;

    return Obx(() => FlutterToggleTab(
          width: 50,
          borderRadius: 15,
          selectedBackgroundColors: const [
            IColors.attentionColor,
          ],
          unSelectedBackgroundColors: const [IColors.backgroundDark],
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: IFont.primaryFontBold,
          ),
          unSelectedTextStyle: const TextStyle(
            fontFamily: IFont.primaryFontBold,
            color: Colors.white,
            fontSize: 15,
          ),
          labels: _desc,
          icons: _icons,
          selectedIndex: selItem,
          selectedLabelIndex: (index) {
            widget.controller.changeMode(index);
            selItem = index;
          },
        ));
  }
}
