import 'package:file_nest/src/services/snackbar_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SETTINGS_Controller extends GetxController {
  void clearArtefacts() {
    showSnackbarInformations("not yet implemnted", infoType: SnackBarType.error);
  }

  void clearLogs() {
    showSnackbarInformations("not yet implemnted", infoType: SnackBarType.error);
  }

  void showAboutPage(BuildContext context) {
showAboutDialog(context: context);
    
  }
}
