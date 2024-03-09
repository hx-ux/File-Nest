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
            const Text(""),
           
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
