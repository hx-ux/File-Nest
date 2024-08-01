import 'package:flutter/material.dart';

class CardExample extends StatelessWidget {
  const CardExample({super.key, required this.message, required this.time, required this.icon, required this.color, required this.filena});

final String message;
final String filena;
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
              title: Text(filena),
              subtitle: Text(time + " "+  message) ,
            ),
          ],
        ),
      ),
    );
  }
}
