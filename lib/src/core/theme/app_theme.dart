import 'package:flutter/material.dart';
import 'package:file_nest/src/core/theme/fonts.style.dart';
import 'colors.style.dart';

ThemeData appThemeData = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  primaryColor: IColors.attentionColor,
  scaffoldBackgroundColor: IColors.background,
  // overides the navbar buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return IColors.background;
      },
    ),
    elevation: MaterialStateProperty.resolveWith<double?>(
      (Set<MaterialState> states) {
        return 0.0;
      },
    ),
    
  )),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        color: IColors.background,
        fontFamily: IFont.primaryFontBold,
        fontSize: 15),
  ),
  iconTheme: const IconThemeData(color: IColors.background),
);
