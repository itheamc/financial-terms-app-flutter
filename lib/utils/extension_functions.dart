import 'package:flutter/material.dart';

/// Extension function on theme data
extension ThemeDataExt on ThemeData {
  bool get light => brightness == Brightness.light;

  bool get dark => brightness == Brightness.dark;

  bool get mobilePlatform =>
      platform == TargetPlatform.android || platform == TargetPlatform.iOS;

  bool get windowsPlatform => platform == TargetPlatform.windows;

  bool get macOsPlatform => platform == TargetPlatform.macOS;

  bool get linuxPlatform => platform == TargetPlatform.linux;
}
