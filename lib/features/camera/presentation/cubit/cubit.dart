import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

enum CameraStatus { initial, loading, ready, capturing, failure }

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState());

  CameraController? _controller;

  List<CameraDescription> _cameras = [];

  bool _isInitializing = false;
  bool _isDisposing = false;

  CameraDescription? _activeCamera;

  CameraController? get controller => _controller;

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  Future<void> initialize() async {
    if (isClosed || _isInitializing || _isDisposing) {
      return;
    }

    // If controller is ready — do nothing.
    if (_controller?.value.isInitialized == true) {
      return;
    }

    _isInitializing = true;

    emit(state.copyWith(status: CameraStatus.loading, error: null));

    try {
      // Getting cameras list (just once).
      if (_cameras.isEmpty) {
        _cameras = await availableCameras();

        if (_cameras.isEmpty) {
          throw CameraException(
            'NoCamerasAvailable',
            'No cameras available on this device.',
          );
        }
      }

      final camera = _activeCamera ?? _cameras[_findInitialCameraIndex()];

      await _initializeController(camera);
    } on CameraException catch (e) {
      _handleCameraException(e);
    } catch (e) {
      _emitFailure(e.toString());
    } finally {
      _isInitializing = false;
    }
  }

  int _findInitialCameraIndex() {
    final backCameraIndex = _cameras.indexWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );

    if (backCameraIndex != -1) {
      return backCameraIndex;
    }

    return 0;
  }

  Future<void> _initializeController(CameraDescription camera) async {
    if (isClosed || _isDisposing) {
      return;
    }

    await _disposeController();

    if (isClosed || _isDisposing) {
      return;
    }

    _activeCamera = camera;

    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = controller;

    try {
      await controller.initialize();

      if (isClosed || _isDisposing) {
        await controller.dispose();
        return;
      }

      final minZoom = await controller.getMinZoomLevel();

      final maxZoom = await controller.getMaxZoomLevel();

      await controller.setFlashMode(FlashMode.off);

      final cameraIndex = _cameras.indexWhere(
        (item) => item.name == camera.name,
      );

      emit(
        state.copyWith(
          status: CameraStatus.ready,
          cameras: List.unmodifiable(_cameras),
          selectedCameraIndex: cameraIndex == -1 ? 0 : cameraIndex,
          flashMode: FlashMode.off,
          minZoom: minZoom,
          maxZoom: maxZoom,
          zoom: minZoom,
          error: null,
        ),
      );
    } catch (e) {
      // Controller could be replaced/destroyed during the asynchronous
      // initialization.
      if (identical(_controller, controller)) {
        _controller = null;
      }

      await controller.dispose();

      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  Future<void> onAppInactive() async {
    if (isClosed || _isDisposing) {
      return;
    }

    final controller = _controller;

    if (controller == null) {
      return;
    }

    // Current camera saved.
    _activeCamera = controller.description;

    // The camera plugin requires releasing camera resources
    // when the application becomes inactive.
    await _disposeController();
  }

  Future<void> onAppResumed() async {
    if (isClosed || _isDisposing) {
      return;
    }

    // While the application was minimized, the controller was destroyed.
    if (_controller == null) {
      await initialize();
    }
  }

  // ---------------------------------------------------------------------------
  // Camera switching
  // ---------------------------------------------------------------------------

  Future<void> switchCamera() async {
    if (isClosed ||
        _isInitializing ||
        _isDisposing ||
        state.isCapturing ||
        _cameras.length < 2) {
      return;
    }

    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    final currentCamera = controller.description;

    final targetDirection =
        currentCamera.lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    final targetIndex = _cameras.indexWhere(
      (camera) => camera.lensDirection == targetDirection,
    );

    if (targetIndex == -1) {
      return;
    }

    final targetCamera = _cameras[targetIndex];

    emit(state.copyWith(status: CameraStatus.loading));

    try {
      _activeCamera = targetCamera;

      // setDescription() allows reusing of an existing CameraController.
      await controller.setDescription(targetCamera);

      if (isClosed) {
        return;
      }

      final minZoom = await controller.getMinZoomLevel();

      final maxZoom = await controller.getMaxZoomLevel();

      // After changing the camera, we reset the flash.
      await controller.setFlashMode(FlashMode.off);

      emit(
        state.copyWith(
          status: CameraStatus.ready,
          selectedCameraIndex: targetIndex,
          flashMode: FlashMode.off,
          minZoom: minZoom,
          maxZoom: maxZoom,
          zoom: minZoom,
          error: null,
        ),
      );
    } on CameraException catch (e) {
      _handleCameraException(e);

      // If the camera switching mechanism has broken,
      // the controller may still be usable..

      if (!isClosed && _controller?.value.isInitialized == true) {
        emit(state.copyWith(status: CameraStatus.ready));
      }
    } catch (e) {
      _emitError(e.toString());

      if (!isClosed && _controller?.value.isInitialized == true) {
        emit(state.copyWith(status: CameraStatus.ready));
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Flash
  // ---------------------------------------------------------------------------

  Future<void> toggleFlash() async {
    final controller = _controller;

    if (controller == null ||
        !controller.value.isInitialized ||
        state.isCapturing ||
        !state.hasFlash) {
      return;
    }

    final newMode = state.flashMode == FlashMode.off
        ? FlashMode.always
        : FlashMode.off;

    try {
      await controller.setFlashMode(newMode);

      if (isClosed) {
        return;
      }

      emit(state.copyWith(flashMode: newMode));
    } on CameraException catch (e) {
      _emitError(e.description ?? e.code);
    }
  }

  // ---------------------------------------------------------------------------
  // Zoom
  // ---------------------------------------------------------------------------

  Future<void> setZoom(double zoom) async {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    final clampedZoom = zoom.clamp(state.minZoom, state.maxZoom);

    try {
      await controller.setZoomLevel(clampedZoom);

      if (isClosed) {
        return;
      }

      emit(state.copyWith(zoom: clampedZoom));
    } on CameraException catch (e) {
      _emitError(e.description ?? e.code);
    }
  }

  // ---------------------------------------------------------------------------
  // Focus
  // ---------------------------------------------------------------------------

  Future<void> setFocusPoint(Offset point) async {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    try {
      // Point should be normalized:
      // x: 0..1
      // y: 0..1
      await controller.setFocusPoint(point);
    } on CameraException {
      // Not all cameras/devices support manual focus point selection.
    }
  }

  // ---------------------------------------------------------------------------
  // Capture
  // ---------------------------------------------------------------------------

  Future<Uint8List?> takePicture() async {
    final controller = _controller;

    if (controller == null ||
        !controller.value.isInitialized ||
        state.isCapturing ||
        controller.value.isTakingPicture) {
      return null;
    }

    try {
      emit(state.copyWith(status: CameraStatus.capturing));

      final XFile file = await controller.takePicture();

      final bytes = await file.readAsBytes();

      if (isClosed) {
        return bytes;
      }

      emit(state.copyWith(status: CameraStatus.ready));

      return bytes;
    } on CameraException catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            status: CameraStatus.ready,
            error: e.description ?? e.code,
          ),
        );
      }

      return null;
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(status: CameraStatus.ready, error: e.toString()));
      }

      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Errors
  // ---------------------------------------------------------------------------

  void _handleCameraException(CameraException exception) {
    switch (exception.code) {
      case 'CameraAccessDenied':
        _emitFailure('errors.camera.cameraAccessDenied'.tr());
        break;

      case 'CameraAccessDeniedWithoutPrompt':
        _emitFailure('errors.camera.cameraAccessDeniedWithoutPrompt'.tr());
        break;

      case 'CameraAccessRestricted':
        _emitFailure('errors.camera.cameraAccessRestricted'.tr());
        break;

      default:
        _emitFailure(exception.description ?? exception.code);
    }
  }

  void _emitFailure(String message) {
    if (isClosed) {
      return;
    }

    emit(state.copyWith(status: CameraStatus.failure, error: message));
  }

  void _emitError(String message) {
    if (isClosed) {
      return;
    }

    emit(state.copyWith(error: message));
  }

  // ---------------------------------------------------------------------------
  // Dispose
  // ---------------------------------------------------------------------------

  Future<void> _disposeController() async {
    final controller = _controller;

    if (controller == null) {
      return;
    }

    _controller = null;

    try {
      await controller.dispose();
    } catch (_) {
      // Controller can be destroyed by camera plugin/platform
    }
  }

  @override
  Future<void> close() async {
    _isDisposing = true;

    await _disposeController();

    return super.close();
  }
}
