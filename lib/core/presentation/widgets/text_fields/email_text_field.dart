import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app_text_form_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.enabled,
    required this.emailController,
  });

  final bool enabled;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: emailController,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'loginScreen.fieldNameEmail'.tr(),
        prefixIcon: const Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'fieldValidation.enterEmail'.tr();
        }
        return null;
      },
    );
  }
}
