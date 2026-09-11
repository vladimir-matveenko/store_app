import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension StringX on String {
  String normalize() => trim().toLowerCase();
}

extension IntegerX on int {
  int min(int other) => this < other ? this : other;

  int max(int other) => this > other ? this : other;
}

extension DateX on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String format({required String format, required String locale}) {
    return DateFormat(format, locale).format(this);
  }
}

extension ThemeDataX on ThemeData {
  bool get isDark => brightness == Brightness.dark;

  bool get isLight => brightness == Brightness.light;
}

extension BuildContextX on BuildContext {
  bool isLandscape() {
    final screenSize = MediaQuery.sizeOf(this);
    return screenSize.width > screenSize.height;
  }

  DateFormat get dateFormatter => DateFormat('yyyy.MM.dd', locale.languageCode);

  DateFormat get timeFormatter => DateFormat('H:mm', locale.languageCode);
}
