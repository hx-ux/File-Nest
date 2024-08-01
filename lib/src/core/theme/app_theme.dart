import 'package:flutter/material.dart';
import 'package:file_nest/src/core/theme/fonts.style.dart';
import 'colors.style.dart';

ThemeData appThemeDataDark = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  primaryColor: IColors.attentionColor,
  scaffoldBackgroundColor: IColors.backgroundDark,
  // overides the navbar buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return IColors.backgroundDark;
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
        color: IColors.backgroundDark,
        fontFamily: IFont.primaryFontBold,
        fontSize: 15),
  ),
  iconTheme: const IconThemeData(color: IColors.backgroundDark),
);


ThemeData appThemeDataBright = ThemeData(
  brightness: Brightness.light,
  useMaterial3: false,
  primaryColor: IColors.attentionColor,
  scaffoldBackgroundColor: IColors.backgroundLight,
  // overides the navbar buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return IColors.backgroundLight;
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
        color: IColors.backgroundDark,
        fontFamily: IFont.primaryFontBold,
        fontSize: 15),
  ),
  iconTheme: const IconThemeData(color: IColors.backgroundLight));