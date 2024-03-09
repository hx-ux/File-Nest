// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';


import 'package:shared_preferences/shared_preferences.dart';

void persitDarkMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('darkmode', 'value');
}