import 'package:file_nest/core/theme/fonts.style.dart';
import 'package:flutter/material.dart';
import 'colors.style.dart';

TextTheme _buildTextTheme(Color textColor, Color mutedColor) {
  return TextTheme(
    displaySmall: TextStyle(
      fontFamily: IFont.primaryFontBold,
      fontSize: 30,
      color: textColor,
      letterSpacing: -0.2,
    ),
    titleLarge: TextStyle(
      fontFamily: IFont.primaryFontSemiBold,
      fontSize: 20,
      color: textColor,
    ),
    titleMedium: TextStyle(
      fontFamily: IFont.primaryFontMedium,
      fontSize: 16,
      color: textColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: IFont.primaryFontRegular,
      fontSize: 16,
      color: textColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: IFont.primaryFontRegular,
      fontSize: 14,
      color: textColor,
    ),
    bodySmall: TextStyle(
      fontFamily: IFont.primaryFontRegular,
      fontSize: 12,
      color: mutedColor,
    ),
    labelLarge: TextStyle(
      fontFamily: IFont.primaryFontSemiBold,
      fontSize: 13,
      color: textColor,
    ),
  );
}

ThemeData appThemeDataDark = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  colorScheme: IColors.darkScheme,
  scaffoldBackgroundColor: IColors.backgroundDark,
  textTheme: _buildTextTheme(IColors.textDark, IColors.mutedDark),
  iconTheme: const IconThemeData(color: IColors.textDark),
  dividerColor: IColors.outlineDark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: IColors.transparent,
      foregroundColor: IColors.textDark,
      textStyle: const TextStyle(fontFamily: IFont.primaryFontSemiBold),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: IColors.textDark,
    textColor: IColors.textDark,
    dense: false,
  ),
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.selected)
            ? IColors.primaryDark
            : IColors.surfaceAltDark;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.selected)
            ? IColors.backgroundDark
            : IColors.textDark;
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: IColors.primaryDark,
    foregroundColor: Colors.white,
  ),
);

ThemeData appThemeDataBright = ThemeData(
  brightness: Brightness.light,
  useMaterial3: false,
  colorScheme: IColors.lightScheme,
  scaffoldBackgroundColor: IColors.backgroundLight,
  textTheme: _buildTextTheme(IColors.textLight, IColors.mutedLight),
  iconTheme: const IconThemeData(color: IColors.textLight),
  dividerColor: IColors.outlineLight,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: IColors.transparent,
      foregroundColor: IColors.textLight,
      textStyle: const TextStyle(fontFamily: IFont.primaryFontSemiBold),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: IColors.textLight,
    textColor: IColors.textLight,
    dense: false,
  ),
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.selected)
            ? IColors.primary
            : IColors.surfaceAltLight;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.selected)
            ? Colors.white
            : IColors.textLight;
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: IColors.primary,
    foregroundColor: Colors.white,
  ),
);
