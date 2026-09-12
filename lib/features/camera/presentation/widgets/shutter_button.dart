import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';

class ShutterButton extends StatelessWidget {
  const ShutterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final enabled = !state.isCapturing;

        return GestureDetector(
          onTap: enabled
              ? () async {
                  final bytes = await context.read<CameraCubit>().takePicture();

                  if (bytes == null || !context.mounted) {
                    return;
                  }

                  context.pop(bytes);
                }
              : null,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: enabled ? 1.0 : 0.5,
            child: Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              padding: const EdgeInsets.all(5),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
