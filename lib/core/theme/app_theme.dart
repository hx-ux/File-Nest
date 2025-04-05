import 'package:file_nest/core/theme/fonts.style.dart';
import 'package:flutter/material.dart';
import 'colors.style.dart';



  ThemeData appThemeDataDark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: false,
    primaryColor: IColors.attentionColor,
    scaffoldBackgroundColor: IColors.backgroundDark,
    // overides the navbar buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return IColors.transparent;
        },
      ),
      elevation: WidgetStateProperty.resolveWith<double?>(
        (Set<WidgetState> states) {
          return 0.0;
        },
      ),
    )),
  );

ThemeData appThemeDataBright = ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,
    primaryColor: IColors.attentionColor,
    scaffoldBackgroundColor: IColors.backgroundLight,
    // overides the navbar buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      iconColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return IColors.backgroundDark;
        },
      ),
      elevation: WidgetStateProperty.resolveWith<double?>(
        (Set<WidgetState> states) {
          return 0.0;
        },
      ),
    )),
    primaryIconTheme: IconThemeData(color: IColors.backgroundDark),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: IColors.backgroundDark,
          fontFamily: IFont.primaryFontBold,
          fontSize: 15),
    ),
    iconTheme: const IconThemeData(color: IColors.backgroundDark));
