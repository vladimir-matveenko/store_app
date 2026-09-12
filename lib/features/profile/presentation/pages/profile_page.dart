import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../app/routes/pages.dart';
import '../../../../core/data/utils/utils.dart';
import '../../../../core/presentation/widgets/app_loader.dart';
import '../../../../core/presentation/widgets/user_avatar.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../widgets/language_selector.dart';
import '../widgets/theme_selector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ThemeData theme;
  late TextTheme textTheme;
  bool _showSelector = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _showSelector = true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    textTheme = theme.textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: AppLoader());
        }
        final avatar = state.user?.avatar ?? '';
        final name = state.user?.name ?? '';
        final firstName = AppUtils.getFirstName(name);
        final lastName = AppUtils.getLastName(name);
        return Center(
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatar(
                avatar: avatar,
                size: 80.0,
                firstName: firstName,
                lastName: lastName,
              ),
              Text(name, style: textTheme.headlineSmall),
              Text(
                '${'loginScreen.fieldNameEmail'.tr()}: ${state.user?.email}',
                style: textTheme.bodyLarge,
              ),
              Text(
                '${'profileScreen.role'.tr()}: ${state.user?.role.name}',
                style: textTheme.bodyLarge,
              ),
              if (_showSelector) ...[
                const ThemeSelector(),
                const LanguageSelector(),
              ] else
                const SizedBox(),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
                onPressed: () {
                  context.go('${Pages.profile}/${Pages.editProfile}');
                },
                child: Row(
                  spacing: 4.0,
                  mainAxisSize: .min,
                  children: [
                    Text('editProfileScreen.screenName'.tr()),
                    Icon(
                      Icons.edit,
                      color: theme.colorScheme.primary,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 8.0,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'profileScreen.btnLogout'.tr(),
                    style: textTheme.bodyLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const LogoutRequested());
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surfaceTint,
                    ),
                    icon: Icon(
                      Icons.logout,
                      size: 28.0,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
