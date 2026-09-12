import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/constants/app_enums.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_event.dart';

import '../../../../core/data/utils/utils.dart';
import '../../../../core/presentation/widgets/app_back_button.dart';
import '../../../../core/presentation/widgets/app_dialog.dart';
import '../../../../core/presentation/widgets/scrolled_wrapper.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/create_profile_form.dart';
import '../widgets/get_image_dialog.dart';
import '../widgets/profile_screen_wrapper.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  late ProfileBloc bloc;
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();
  final obscure = ValueNotifier<bool>(true);
  bool jobDone = false;

  void _handleCreateProfile() {
    if (_formKey.currentState!.validate()) {
      bloc.add(
        CreateProfileRequested(
          name: _userNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          role: _roleController.text,
          avatarUrl: '',
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ProfileBloc>();
    _roleController.text = UserRole.customer.name;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('createProfileScreen.screenName'.tr()),
        centerTitle: true,
        leading: const AppBackButton(),
      ),
      resizeToAvoidBottomInset: true,
      body: ProfileScreenWrapper(
        successMessage: '',
        buildBody: (context, state) {
          final isLoading = state.isLoading;
          final isBlocked = jobDone;
          return ScrolledWrapper(
            child: CreateProfileForm(
              isFormActive: !isLoading && !isBlocked,
              isLoading: isLoading,
              isAvatarLoading: state.isAvatarLoading,
              formKey: _formKey,
              userNameController: _userNameController,
              emailController: _emailController,
              passwordController: _passwordController,
              onSaveTapped: _handleCreateProfile,
              mainButtonText: 'createProfileScreen.btnCreate'.tr(),
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
            ),
          );
        },
        onJobDone: () {
          jobDone = true;
        },
        onSuccess: () {
          AppDialog.empty(
            context,
            onClose: () {
              context.pop();
            },
            content: Container(
              padding: const .all(32.0),
              constraints: AppUtils.getModalDialogConstraints(context),
              child: Column(
                crossAxisAlignment: .center,
                mainAxisSize: .min,
                spacing: 16.0,
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 60.0),
                  Text('createProfileScreen.createSuccessMessage'.tr()),
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text('okText'.tr()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
