import 'package:file_nest/src/core/theme/colors.style.dart';
import 'package:file_nest/src/core/theme/fonts.style.dart';
import 'package:file_nest/src/views/controllers/SETTINGS_Controller.dart';
import 'package:file_nest/src/views/home_view/widgets/navbar.dart';
import 'package:file_nest/src/views/settings_view/widgets/AboutPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SettingsPage extends GetView<SETTINGS_Controller> {
  SettingsPage({super.key});
  final controller = Get.put(SETTINGS_Controller());
  RxBool moveOrCopy= false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Navbar(
            subpage: true,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              controller.clearLogs();
            },
            child: const Text("Clear logs"),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              controller.clearArtefacts();
            },
            child: const Text("Clear database"),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {
              controller.showAboutPage(context);
            },
            child: const Text("About"),
          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          // child:  ToggleButton(moveOrCopy: moveOrCopy),
        ),
      ],
    ));
  }
}

// class ToggleButton extends StatelessWidget {
//   const ToggleButton({
//     super.key,
//     required this.moveOrCopy,
//   });

//   final RxBool moveOrCopy;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedToggleSwitch<bool>.dual(
//           current: moveOrCopy.value,
//           first: false,
//           second: true,
//           spacing: 50.0,
//           style: const ToggleStyle(
//             borderColor: Colors.transparent,
           
//           ),
//           borderWidth: 5.0,
//           height: 55,
//           onChanged: (b) => () {
//             moveOrCopy!=b;

//           },
//           styleBuilder: (b) => ToggleStyle(
//             backgroundColor: b ? IColors.attentionColor: IColors.background,
//             indicatorColor: b ? Colors.white : Colors.red,
          
//           ),
//           iconBuilder: (value) => Icon(
//             value
//                 ? Icons.copy
//                 : Icons.move_up,
//             size: 30.0,
//             color: value ? Colors.black : Colors.white,
//           ),
//           textBuilder: (value) => value
//               ? const Center(
//                   child:
//                       Text('Copy', style: TextStyle(color: Colors.white,fontFamily: IFont.primaryFontBold)))
//               : const Center(
//                   child:
//                       Text('Move', style: TextStyle(color: Colors.white,fontFamily: IFont.primaryFontBold))),
//         );
//   }
// }
