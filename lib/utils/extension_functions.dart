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


/// Extension FUnction On List
extension ListSortExt on List {
  /// Function to sort the data
  /// [V] - It is the data type to sort. e.g. int, double, num, String, DateTime etc.
  /// [T] - It is an object that's field need to be sorted
  void toSort<V, T>(Comparable<V> Function(T t) field, bool ascending) {
    sort((a, b) {
      final aValue = field(a);
      final bValue = field(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }
}