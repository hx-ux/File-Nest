import 'package:file_nest/core/theme/colors.style.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

List<DataTab> get iconList => [
      DataTab(
        icon: FluentIcons.copy_20_regular,
      ),
      DataTab(
        icon: FluentIcons.arrow_move_20_regular,
      ),
    ];

class ToggleBtn extends StatefulWidget {
  final controller;
  const ToggleBtn({super.key, required this.controller});

  @override
  State<ToggleBtn> createState() => _ToggleBtnState();
}

class _ToggleBtnState extends State<ToggleBtn> {
  @override
  Widget build(BuildContext context) {
    return FlutterToggleTab(
      width: 30,
      borderRadius: 10,
      selectedIndex: widget.controller.copyOrMove.value,
      selectedBackgroundColors: const [IColors.primary],
      isShadowEnable: false,
      unSelectedBackgroundColors: [IColors.backgroundDark],
      dataTabs: iconList,
      selectedLabelIndex: (index) => widget.controller.copyOrMove.value = index,
      isScroll: false,
    );
  }
}
