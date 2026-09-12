import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/widgets/app_message.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets/camera_content.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CameraCubit()..initialize(),
      child: Scaffold(
        body: BlocConsumer<CameraCubit, CameraState>(
          listenWhen: (previous, current) => previous.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty == true) {
              AppMessage.error(context, message: state.error!);
            }
          },
          builder: (context, state) {
            if (state.status == CameraStatus.initial ||
                state.status == CameraStatus.loading) {
              return const LoadingView();
            }

            if (state.status == CameraStatus.failure) {
              return ErrorView(
                message: state.error ?? 'errors.camera.unableInitialize'.tr(),
                onRetry: () {
                  context.read<CameraCubit>().initialize();
                },
                onClose: () {
                  context.pop();
                },
              );
            }

            return const CameraContent();
          },
        ),
      ),
    );
  }
}
