import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:store_app/features/users/presentation/bloc/users_event.dart';
import 'package:store_app/features/users/presentation/bloc/users_state.dart';

import '../../../../app/utils/utils.dart';
import '../../../../core/presentation/widgets/app_loader.dart';
import '../../../../core/presentation/widgets/user_avatar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.id});

  final String id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controller = CarouselSliderController();

  bool _imageReady = false;
  bool _imageInProgress = false;

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(UserFetched(widget.id));
  }

  Future<void> _precacheAvatar(String avatarUrl) async {
    if (avatarUrl.isEmpty) {
      if (!mounted) return;

      setState(() {
        _imageReady = true;
        _imageInProgress = false;
      });

      return;
    }

    _imageInProgress = true;

    await AppUtils.precacheImages(context, images: [avatarUrl]);

    if (!mounted) return;

    setState(() {
      _imageReady = true;
      _imageInProgress = false;
    });
  }

  void _handleUserLoaded(UsersState state) {
    final avatar = state.user?.avatar ?? '';

    if (state.user == null || _imageReady || _imageInProgress) {
      return;
    }

    _precacheAvatar(avatar);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          _handleUserLoaded(state);
        },
        builder: (context, state) {
          final user = state.user;
          final avatar = user?.avatar ?? '';
          final name = user?.name ?? '';

          final firstName = AppUtils.getFirstName(name);
          final lastName = AppUtils.getLastName(name);

          final isLoading = state.isUserLoading || !_imageReady;

          if (isLoading) {
            return const AppLoader();
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                spacing: 24.0,
                children: [
                  UserAvatar(
                    avatar: avatar,
                    size: 160.0,
                    firstName: firstName,
                    lastName: lastName,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8.0,
                    children: [
                      Text(user?.email ?? '', style: textTheme.bodyMedium),
                      Text(user?.name ?? '', style: textTheme.bodyLarge),
                      Text(user?.role.name ?? '', style: textTheme.bodySmall),
                    ],
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
