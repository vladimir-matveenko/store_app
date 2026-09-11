import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app_text_form_field.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.enabled,
    required this.passwordController,
    required this.obscure,
    required this.onObscureChanged,
    this.hintText,
    this.validator,
  });

  final bool enabled;
  final TextEditingController passwordController;
  final ValueNotifier<bool> obscure;
  final Function(bool) onObscureChanged;
  final String? hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscure,
      builder: (context, value, child) {
        return AppTextFormField(
          controller: passwordController,
          enabled: enabled,
          obscureText: value,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: hintText ?? 'loginScreen.fieldNamePassword'.tr(),
            prefixIcon: GestureDetector(
              onTap: () {
                onObscureChanged(!obscure.value);
              },
              child: Icon(value ? Icons.lock : Icons.lock_open),
            ),
          ),
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'fieldValidation.enterPassword'.tr();
                }
                if (value.length < 8) {
                  return 'fieldValidation.minPasLength'.tr();
                }
                return null;
              },
        );
      },
    );
  }
}
