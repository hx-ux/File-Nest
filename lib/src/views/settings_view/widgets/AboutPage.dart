import 'package:file_nest/config.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAboutPage(BuildContext context) async {
  var mediaQuery = MediaQuery.of(context);
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Center(child: Text('About')),
      content: SizedBox(
        height: mediaQuery.size.height*0.2,
        width: mediaQuery.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(AppSettings.appName),
            const Text(AppSettings.appVersion),
            const Text(AppSettings.isStable ? "Stable" : "Unstable"),
           
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Exit"),
            ),
          ],
        ),
      ),
    ),
  );
}
