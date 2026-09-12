import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({
    super.key,
    required this.controller,
    required this.onZoomStart,
    required this.onZoomUpdate,
    required this.onTap,
  });

  final CameraController controller;
  final VoidCallback onZoomStart;
  final ValueChanged<double> onZoomUpdate;
  final ValueChanged<Offset> onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,

          onScaleStart: (_) {
            onZoomStart();
          },

          onScaleUpdate: (details) {
            onZoomUpdate(details.scale);
          },

          onTapDown: (details) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            if (width <= 0 || height <= 0) {
              return;
            }

            final point = Offset(
              details.localPosition.dx / width,
              details.localPosition.dy / height,
            );

            onTap(Offset(point.dx.clamp(0.0, 1.0), point.dy.clamp(0.0, 1.0)));
          },

          child: CameraPreview(controller),
        );
      },
    );
  }
}
