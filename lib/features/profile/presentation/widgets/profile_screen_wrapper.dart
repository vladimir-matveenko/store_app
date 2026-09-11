import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_event.dart';

import '../../../../core/presentation/widgets/app_message.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({
    super.key,
    required this.successMessage,
    required this.buildBody,
    required this.onJobDone,
    required this.onSuccess,
  });

  final String successMessage;
  final Widget Function(BuildContext, ProfileState) buildBody;
  final VoidCallback onJobDone;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: buildBody,
      listener: (context, state) {
        if (state.error?.isNotEmpty == true) {
          AppMessage.error(
            context,
            message: state.error!,
            onClose: () {
              context.read<ProfileBloc>().add(const DisableErrorRequested());
            },
          );
        }
        if (state.createdSuccessful || state.updatedSuccessful) {
          onJobDone.call();
          if (successMessage.isNotEmpty) {
            AppMessage.success(
              context,
              message: successMessage,
              onClose: () {
                context.read<ProfileBloc>().add(
                  const DisableSuccessRequested(),
                );
                onSuccess.call();
              },
            );
          } else {
            context.read<ProfileBloc>().add(const DisableSuccessRequested());
            onSuccess.call();
          }
        }
      },
    );
  }
}
