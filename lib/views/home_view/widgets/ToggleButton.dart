import 'package:file_nest/core/theme/fonts.style.dart';
import 'package:file_nest/core/theme/icons.style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Map<String, IconData> _iconsMap = {
  "copy": AppIcons.copy,
  "move": AppIcons.move,
};

class ToggleBtn extends StatefulWidget {
  final controller;
  const ToggleBtn({super.key, required this.controller});

  @override
  State<ToggleBtn> createState() => _ToggleBtnState();
}

class _ToggleBtnState extends State<ToggleBtn> {
  @override
  Widget build(BuildContext context) {
    late int selItem = widget.controller.copyOrMove.value.index;
    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() => FlutterToggleTab(
          width: 46,
          borderRadius: 15,
          selectedBackgroundColors: [colorScheme.primary],
          unSelectedBackgroundColors: [colorScheme.surfaceContainerHighest],
          selectedTextStyle: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 15,
            fontFamily: IFont.primaryFontBold,
          ),
          unSelectedTextStyle: TextStyle(
            fontFamily: IFont.primaryFontBold,
            color: colorScheme.onSurface,
            fontSize: 15,
          ),
          labels: _iconsMap.keys.toList(),
          icons: _iconsMap.values.toList(),
          selectedIndex: selItem,
          selectedLabelIndex: (index) {
            widget.controller.changeMode(index);
            selItem = index;
          },
        ));
  }
}
