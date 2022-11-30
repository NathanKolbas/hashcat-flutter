import 'package:flutter/material.dart';

final ColorScheme blueSchemeLight = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.blue,
  primary: Colors.blue[600],
  secondary: Colors.blue[900],
);

final ColorScheme blueSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.blue,
  primary: Colors.blue[600],
  secondary: Colors.blue[400],
);

final ThemeData themeLight = ThemeData(
  colorScheme: blueSchemeLight,
  primaryColor: blueSchemeLight.primary,
  primaryColorLight: Color.alphaBlend(Colors.white.withAlpha(0x66), blueSchemeLight.primary),
  primaryColorDark: Color.alphaBlend(Colors.black.withAlpha(0x66), blueSchemeLight.primary),
  secondaryHeaderColor: Color.alphaBlend(Colors.white.withAlpha(0xCC), blueSchemeLight.primary),
  toggleableActiveColor: blueSchemeLight.secondary,
  scaffoldBackgroundColor: blueSchemeLight.background,
  canvasColor: blueSchemeLight.background,
  backgroundColor: blueSchemeLight.background,
  cardColor: blueSchemeLight.surface,
  bottomAppBarColor: blueSchemeLight.surface,
  dialogBackgroundColor: blueSchemeLight.surface,
  indicatorColor: blueSchemeLight.onPrimary,
  dividerColor: blueSchemeLight.onSurface.withOpacity(0.12),
  errorColor: blueSchemeLight.error,
  applyElevationOverlayColor: false,
);

final ThemeData themeDark = ThemeData(
  colorScheme: blueSchemeDark,
  primaryColor: blueSchemeDark.primary,
  primaryColorLight: Color.alphaBlend(Colors.white.withAlpha(0x59), blueSchemeDark.primary),
  primaryColorDark: Color.alphaBlend(Colors.black.withAlpha(0x72), blueSchemeDark.primary),
  secondaryHeaderColor: Color.alphaBlend(Colors.black.withAlpha(0x99), blueSchemeDark.primary),
  toggleableActiveColor: blueSchemeDark.secondary,
  scaffoldBackgroundColor: blueSchemeDark.background,
  canvasColor: blueSchemeDark.background,
  backgroundColor: blueSchemeDark.background,
  cardColor: blueSchemeDark.surface,
  bottomAppBarColor: blueSchemeDark.surface,
  dialogBackgroundColor: blueSchemeDark.surface,
  indicatorColor: blueSchemeDark.primary,
  dividerColor: blueSchemeDark.onSurface.withOpacity(0.12),
  errorColor: blueSchemeDark.error,
  applyElevationOverlayColor: true,
);
