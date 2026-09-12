import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'camera_button.dart';

class CameraTopBar extends StatelessWidget {
  const CameraTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CameraButton(
              icon: Icons.close,
              onPressed: () {
                context.pop();
              },
            ),

            BlocBuilder<CameraCubit, CameraState>(
              buildWhen: (previous, current) =>
                  previous.flashMode != current.flashMode ||
                  previous.selectedCameraIndex != current.selectedCameraIndex ||
                  previous.status != current.status,
              builder: (context, state) {
                if (!state.hasFlash) {
                  return const SizedBox(width: 56, height: 56);
                }

                return CameraButton(
                  icon: state.flashMode == FlashMode.off
                      ? Icons.flash_off
                      : Icons.flash_on,
                  onPressed: state.isCapturing
                      ? null
                      : () {
                          context.read<CameraCubit>().toggleFlash();
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
