import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/camera/presentation/widgets/shutter_button.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'camera_button.dart';

class CameraBottomBar extends StatelessWidget {
  const CameraBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const .fromLTRB(24, 24, 24, 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 56, height: 56),

              const ShutterButton(),

              BlocBuilder<CameraCubit, CameraState>(
                buildWhen: (previous, current) =>
                    previous.selectedCameraIndex !=
                        current.selectedCameraIndex ||
                    previous.status != current.status,
                builder: (context, state) {
                  return CameraButton(
                    icon: Icons.flip_camera_ios,
                    onPressed: state.canSwitchCamera && !state.isCapturing
                        ? () {
                            context.read<CameraCubit>().switchCamera();
                          }
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
