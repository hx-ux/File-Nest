import 'package:file_nest/src/views/controllers/SETTINGS_Controller.dart';
import 'package:file_nest/src/views/home_view/widgets/navbar.dart';
import 'package:file_nest/src/views/settings_view/widgets/AboutPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SettingsPage extends GetView<SETTINGS_Controller> {
  const SettingsPage({super.key});


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
            onPressed: () {controller.clearLogs();},
            child: const Text("Clear logs"),
          ),
        ),

         SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {controller.clearArtefacts();},
            child: const Text("Clear database"),
          ),
        ),
                  
              SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () {showAboutPage(context);},
            child: const Text("About"),
          ),
        ),
                  

      ],
    ));
  }
}
