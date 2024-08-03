import 'package:flutter/material.dart';

class CardExample extends StatelessWidget {
  const CardExample.LogCard({super.key, required this.message, required this.time, required this.icon, required this.color, required this.filename});

final String message;
final String filename;
final String time;
final IconData icon;
final Color color;	

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: color,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(icon),
              title: Text(message),
              subtitle: Text("$time: $filename") ,
            ),
          ],
        ),
      ),
    );
  }
}
