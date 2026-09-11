import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
}
