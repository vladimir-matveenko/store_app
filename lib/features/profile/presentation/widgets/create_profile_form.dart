import 'package:flutter/material.dart';
import 'package:store_app/features/profile/presentation/widgets/role_selector.dart';

import '../../../../app/constants/app_enums.dart';
import '../../../../core/presentation/widgets/app_loader.dart';
import '../../../../core/presentation/widgets/text_fields/email_text_field.dart';
import '../../../../core/presentation/widgets/text_fields/password_field.dart';
import '../../../../core/presentation/widgets/text_fields/username_text_field.dart';
import '../../../products/domain/entity/app_image_entity.dart';
import 'create_profile_avatar.dart';

class CreateProfileForm extends StatelessWidget {
  const CreateProfileForm({
    super.key,
    required this.isFormActive,
    required this.isLoading,
    required this.isAvatarLoading,
    required this.formKey,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.onSaveTapped,
    required this.mainButtonText,
    required this.obscure,
    required this.onObscureChanged,
    required this.onRoleChanged,
    this.image,
    required this.onAddImageTapped,
    this.currentAvatar,
    this.onDeleteTap,
  });

  final bool isFormActive;
  final bool isLoading;
  final bool isAvatarLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSaveTapped;
  final String mainButtonText;
  final ValueNotifier<bool> obscure;
  final Function(bool) onObscureChanged;
  final Function(UserRole) onRoleChanged;
  final AppImageEntity? image;
  final VoidCallback onAddImageTapped;
  final VoidCallback? onDeleteTap;
  final Widget? currentAvatar;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: .center,
        spacing: 16.0,
        children: [
          CreateProfileAvatar(
            showLoader: isAvatarLoading,
            image: image,
            onTap: onAddImageTapped,
            currentAvatar: currentAvatar,
            onDeleteTap: onDeleteTap,
          ),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .stretch,
            spacing: 16.0,
            children: [
              UsernameTextField(
                enabled: isFormActive,
                userNameController: userNameController,
              ),
              EmailTextField(
                enabled: isFormActive,
                emailController: emailController,
              ),
              PasswordTextField(
                enabled: isFormActive,
                passwordController: passwordController,
                obscure: obscure,
                onObscureChanged: onObscureChanged,
              ),
              RoleSelector(onChanged: onRoleChanged),
              ElevatedButton(
                onPressed: !isFormActive ? null : onSaveTapped,
                child: isLoading ? AppLoader.small() : Text(mainButtonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
