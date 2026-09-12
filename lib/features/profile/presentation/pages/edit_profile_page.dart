import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/constants/app_enums.dart';
import 'package:store_app/features/products/domain/entity/app_image_entity.dart';

import '../../../../core/presentation/widgets/app_dialog.dart';
import '../../../../core/presentation/widgets/scrolled_wrapper.dart';
import '../../../../core/presentation/widgets/user_avatar.dart';
import '../../domain/entity/user_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../widgets/create_profile_form.dart';
import '../widgets/get_image_dialog.dart';
import '../widgets/profile_screen_wrapper.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late ProfileBloc bloc;
  late UserEntity profile;
  AppImageEntity? avatar;
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();
  final obscure = ValueNotifier<bool>(true);
  bool jobDone = false;

  void _onSave() {
    final newProfile = UserEntity(
      id: profile.id,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _userNameController.text.trim(),
      role: _roleController.text == UserRole.admin.name
          ? UserRole.admin
          : UserRole.customer,
      avatar: avatar != null ? 'new' : profile.avatar,
    );

    final changed = newProfile != profile;

    if (changed) {
      final name = profile.name != newProfile.name ? newProfile.name : null;
      final email = profile.email != newProfile.email ? newProfile.email : null;
      final password = profile.password != newProfile.password
          ? newProfile.password
          : null;
      final role = profile.role != newProfile.role
          ? newProfile.role.name
          : null;
      bloc.add(
        ProfileEvent.updateProfileRequested(
          userId: profile.id,
          name: name,
          email: email,
          password: password,
          role: role,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ProfileBloc>();
    profile = bloc.state.user!;
    _userNameController.text = profile.name;
    _passwordController.text = profile.password;
    _emailController.text = profile.email;
    _roleController.text = profile.role.name;
  }

  @override
  void deactivate() {
    bloc.add(const DisableSuccessRequested());
    super.deactivate();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: ProfileScreenWrapper(
        successMessage: 'editProfileScreen.updated'.tr(),
        buildBody: (context, state) {
          final isLoading = state.isLoading;
          final isBlocked = jobDone;
          avatar = state.avatar;

          return ScrolledWrapper(
            child: CreateProfileForm(
              currentAvatar: Stack(
                alignment: .center,
                children: [
                  UserAvatar(
                    avatar: profile.avatar,
                    size: 80.0,
                    firstName: profile.name,
                    lastName: '',
                  ),
                  const Icon(Icons.add_photo_alternate_outlined, size: 32.0),
                ],
              ),
              isFormActive: !isLoading && !isBlocked,
              isLoading: isLoading,
              isAvatarLoading: state.isAvatarLoading,
              formKey: _formKey,
              userNameController: _userNameController,
              emailController: _emailController,
              passwordController: _passwordController,
              onSaveTapped: _onSave,
              mainButtonText: 'editProfileScreen.btnSave'.tr(),
              obscure: obscure,
              onObscureChanged: (value) {
                obscure.value = value;
              },
              onRoleChanged: (role) {
                _roleController.text = role.name;
              },
              image: state.avatar,
              onAddImageTapped: () {
                if (kIsWeb) {
                  bloc.add(const ImagePicked());
                } else {
                  AppDialog.empty(context, content: const GetImageDialog());
                }
              },
              onDeleteTap: () {
                if (state.avatar != null) {
                  bloc.add(ImageRemoved(image: state.avatar!));
                }
              },
            ),
          );
        },
        onJobDone: () {
          jobDone = true;
        },
        onSuccess: () {
          bloc.add(const UserProfileRequested());
          context.pop();
        },
      ),
    );
  }
}
