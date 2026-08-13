import 'package:flutter/material.dart';

abstract class IColors {
  static const transparent = Color(0x00000000);

  // Brand
  static const primary = Color(0xFF4F8BFF);
  static const primaryDark = Color(0xFF7AA2FF);
  static const secondary = Color(0xFF39D2C0);

  // Light
  static const backgroundLight = Color(0xFFF5F7FB);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceAltLight = Color(0xFFE8EEF6);
  static const textLight = Color(0xFF0F172A);
  static const mutedLight = Color(0xFF475569);
  static const outlineLight = Color(0xFFD4DAE4);

  // Dark
  static const backgroundDark = Color(0xFF0E1116);
  static const surfaceDark = Color(0xFF161B22);
  static const surfaceAltDark = Color(0xFF1D2530);
  static const textDark = Color(0xFFF8FAFC);
  static const mutedDark = Color(0xFFB7C0CE);
  static const outlineDark = Color(0xFF2C3542);

  static const errorColor = Color(0xFFEF4444);
  static const successColor = Color(0xFF10B981);

  static ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: primary,
    secondary: secondary,
    error: errorColor,
    surface: surfaceLight,
    surfaceContainerHighest: surfaceAltLight,
    onSurface: textLight,
    outline: outlineLight,
  );

  static ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: primaryDark,
    brightness: Brightness.dark,
  ).copyWith(
    primary: primaryDark,
    secondary: secondary,
    error: errorColor,
    surface: surfaceDark,
    surfaceContainerHighest: surfaceAltDark,
    onSurface: textDark,
    outline: outlineDark,
  );
}
