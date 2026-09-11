import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/utils/utils.dart';
import 'app_text_form_field.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    super.key,
    required this.enabled,
    required this.userNameController,
    this.hintText,
    this.validator,
  });

  final bool enabled;
  final TextEditingController userNameController;
  final String? hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: userNameController,
      enabled: enabled,
      keyboardType: .name,
      decoration: InputDecoration(
        hintText: hintText ?? 'createProfileScreen.fieldUserName'.tr(),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: validator ?? AppUtils.fieldRequired,
    );
  }
}
