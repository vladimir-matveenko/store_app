import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../../../features/products/domain/entity/app_image_entity.dart';
import '../utils/utils.dart';

@immutable
class ImageService {
  const ImageService._();

  static const _maxImageSize = 1024.0;
  static const _quality = 90;

  static Future<AppImageEntity?> processCameraImage(Uint8List bytes) async {
    try {
      final normalizedBytes = await compute(_normalizeCameraImage, bytes);

      return AppImageEntity(bytes: normalizedBytes, name: 'camera.jpg');
    } catch (e) {
      log('processCameraImage error: $e');
      return null;
    }
  }

  static Future<AppImageEntity?> getImageFromGallery() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: _maxImageSize,
      maxHeight: _maxImageSize,
      imageQuality: _quality,
    );

    if (picked == null) return null;

    try {
      final bytes = await picked.readAsBytes();

      final normalizedBytes = await compute(
        _normalizeImage,
        _NormalizeImageParams(bytes: bytes, originalName: picked.name),
      );

      final ext = AppUtils.getSupportedImageExtension(picked.name);

      final fileName = AppUtils.normalizeFileName(picked.name, ext);

      return AppImageEntity(bytes: normalizedBytes, name: fileName);
    } catch (e) {
      log('getImageFromGallery error: $e');
      return null;
    }
  }

  static Uint8List _normalizeCameraImage(Uint8List bytes) {
    try {
      final image = img.decodeImage(bytes);

      if (image == null) {
        return bytes;
      }

      final normalized = img.bakeOrientation(image);

      return Uint8List.fromList(img.encodeJpg(normalized, quality: _quality));
    } catch (e) {
      log('normalizeCameraImage error: $e');
      return bytes;
    }
  }

  static Uint8List _normalizeImage(_NormalizeImageParams params) {
    try {
      final image = img.decodeImage(params.bytes);

      if (image == null) {
        return params.bytes;
      }

      final normalized = img.bakeOrientation(image);

      final ext = AppUtils.getSupportedImageExtension(params.originalName);

      return _encode(normalized, ext);
    } catch (e) {
      log('normalizeImage error: $e');
      return params.bytes;
    }
  }

  static Uint8List _encode(img.Image image, String ext) {
    return switch (ext) {
      'png' => Uint8List.fromList(img.encodePng(image)),
      'webp' => Uint8List.fromList(img.encodeWebP(image)),
      _ => Uint8List.fromList(img.encodeJpg(image)),
    };
  }
}

class _NormalizeImageParams {
  const _NormalizeImageParams({
    required this.bytes,
    required this.originalName,
  });

  final Uint8List bytes;
  final String originalName;
}
