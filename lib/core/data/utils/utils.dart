import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'extensions.dart';

@immutable
class AppUtils {
  const AppUtils._();

  static String getFirstLetter(String name) {
    if (name.isEmpty) return '';
    return name.substring(0, 1);
  }

  static String getFirstName(String name) {
    if (name.isEmpty) return '';
    return name.split(' ').first;
  }

  static String getLastName(String name) {
    if (name.isEmpty) return '';
    return name.split(' ').last;
  }

  static List<T> parseList<T>(
    List<dynamic> list,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (list.isEmpty) {
      return [];
    }
    return list
        .map((jsonItem) => fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }

  static String? fieldRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'fieldValidation.fieldIsRequired'.tr();
    }
    return null;
  }

  static BoxConstraints getModalDialogConstraints(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isLandscape = context.isLandscape();
    return BoxConstraints(
      maxHeight: isLandscape
          ? screenSize.height - 32.0
          : screenSize.height * 0.7,
      maxWidth: isLandscape
          ? screenSize.height - 32.0
          : screenSize.width - 32.0,
    );
  }
}
