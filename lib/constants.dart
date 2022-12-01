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

// We can always add more, I only added a few... https://hashcat.net/wiki/doku.php?id=hashcat
final hashType = {
  900: "MD4",
  0: "MD5",
  100: "SHA1",
  1400: "SHA2-256",
  1700: "SHA2-512",
  17400: "SHA3-256",
  17600: "SHA3-512"
};

final attackMode = {
  0: "Straight",
  1: "Combination",
  3: "Brute-Force",
  6: "Hybrid Wordlist + Mask",
  7: "Hybrid Mask + Wordlist",
  9: "Association",
};

final outputFormat = {
  "1": "hash[:salt]",
  "2": "plain",
  "3": "hex_plain",
  "4": "crack_pos",
  "5": "timestamp absolute",
  "6": "timestamp relative",
};
