import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'camera_bottom_bar.dart';
import 'camera_preview_widget.dart';
import 'camera_top_bar.dart';
import 'loading_view.dart';

class CameraContent extends StatefulWidget {
  const CameraContent({super.key});

  @override
  State<CameraContent> createState() => _CameraContentState();
}

class _CameraContentState extends State<CameraContent>
    with WidgetsBindingObserver {
  double _baseZoom = 1.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<CameraCubit>();

    switch (state) {
      case AppLifecycleState.inactive:
        cubit.onAppInactive();
        break;

      case AppLifecycleState.resumed:
        cubit.onAppResumed();
        break;

      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CameraCubit>();
    final controller = cubit.controller;

    if (controller == null || !controller.value.isInitialized) {
      return const LoadingView();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreviewWidget(
          controller: controller,
          onZoomStart: () {
            _baseZoom = cubit.state.zoom;
          },
          onZoomUpdate: (scale) {
            final state = cubit.state;

            final zoom = (_baseZoom * scale).clamp(
              state.minZoom,
              state.maxZoom,
            );

            cubit.setZoom(zoom);
          },
          onTap: cubit.setFocusPoint,
        ),

        const Positioned(top: 0.0, left: 0, right: 0, child: CameraTopBar()),

        const CameraBottomBar(),

        BlocBuilder<CameraCubit, CameraState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (!state.isCapturing) {
              return const SizedBox.shrink();
            }

            return const LoadingView();
          },
        ),
      ],
    );
  }
}
