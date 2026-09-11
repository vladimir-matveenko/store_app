import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/app/constants/app_enums.dart';
import 'package:store_app/app/constants/app_strings.dart';

@immutable
class ProfileUtils {
  const ProfileUtils._();

  static Widget getLanguageIcon(String code) {
    var assetName = '';
    switch (code) {
      case 'en':
        assetName = AppStrings.flagUsa;
        break;
      case 'ru':
        assetName = AppStrings.flagRu;
        break;
      default:
        assetName = '';
        break;
    }
    return SizedBox(
      width: 32.0,
      height: 24.0,
      child: SvgPicture.asset(
        assetName,
        errorBuilder: (_, e, s) => const SizedBox(),
      ),
    );
  }

  static Widget getRoleIcon(UserRole role) {
    return switch (role) {
      UserRole.customer => const Icon(Icons.person, size: 24.0),
      UserRole.admin => const Icon(Icons.admin_panel_settings, size: 24.0),
    };
  }
}
