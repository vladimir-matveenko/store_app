import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'cubit.dart';

part 'state.freezed.dart';

@freezed
abstract class CameraState with _$CameraState {
  const CameraState._();

  const factory CameraState({
    @Default(CameraStatus.initial) CameraStatus status,
    @Default([]) List<CameraDescription> cameras,
    @Default(0) int selectedCameraIndex,
    @Default(FlashMode.off) FlashMode flashMode,
    @Default(1.0) double minZoom,
    @Default(1.0) double maxZoom,
    @Default(1.0) double zoom,
    String? error,
  }) = _CameraState;

  CameraDescription? get selectedCamera {
    if (cameras.isEmpty || selectedCameraIndex >= cameras.length) {
      return null;
    }

    return cameras[selectedCameraIndex];
  }

  bool get isInitialized => status == CameraStatus.ready;

  bool get isCapturing => status == CameraStatus.capturing;

  bool get canSwitchCamera => cameras.length > 1;

  bool get hasFlash =>
      selectedCamera?.lensDirection == CameraLensDirection.back;
}
