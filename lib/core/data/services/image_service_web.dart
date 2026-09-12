import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web/web.dart';

import '../../../features/products/domain/entity/app_image_entity.dart';
import '../utils/utils.dart';

@immutable
class ImageService {
  const ImageService._();

  static const _maxImageSize = 1024;
  static const _quality = 0.90;

  static Future<AppImageEntity?> processCameraImage(Uint8List bytes) async {
    /// Is not available on WEB platform
    throw UnimplementedError();
  }

  static Future<AppImageEntity?> getImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked == null) {
      return null;
    }

    try {
      final image = HTMLImageElement()
        ..src = picked.path
        ..decoding = 'async';

      await image.decode().toDart;

      final width = image.naturalWidth;
      final height = image.naturalHeight;

      final size = _calculateSize(width, height);

      final canvas = HTMLCanvasElement()
        ..width = size.width
        ..height = size.height;

      final context = canvas.context2D;

      context.drawImage(image, 0, 0, size.width, size.height);

      final ext = AppUtils.getSupportedImageExtension(picked.name);

      final blob = await _canvasToBlob(canvas, ext);

      if (blob == null) {
        return null;
      }

      final bytes = await _blobToBytes(blob);

      return AppImageEntity(
        bytes: bytes,
        name: AppUtils.normalizeFileName(picked.name, ext),
      );
    } catch (e) {
      return null;
    } finally {
      URL.revokeObjectURL(picked.path);
    }
  }

  static _ImageSize _calculateSize(int width, int height) {
    final maxSide = width > height ? width : height;

    if (maxSide <= _maxImageSize) {
      return _ImageSize(width, height);
    }

    if (width >= height) {
      return _ImageSize(
        _maxImageSize,
        (height * _maxImageSize / width).round(),
      );
    }

    return _ImageSize((width * _maxImageSize / height).round(), _maxImageSize);
  }

  static Future<Blob?> _canvasToBlob(HTMLCanvasElement canvas, String ext) {
    final completer = Completer<Blob?>();

    final callback = ((Blob? blob) {
      completer.complete(blob);
    }).toJS;

    final mimeType = switch (ext) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => 'image/jpeg',
    };

    canvas.toBlob(callback, mimeType, _quality.toJS);

    return completer.future;
  }

  static Future<Uint8List> _blobToBytes(Blob blob) async {
    final arrayBuffer = await blob.arrayBuffer().toDart;

    final jsArray = JSUint8Array(arrayBuffer);

    return jsArray.toDart;
  }
}

class _ImageSize {
  const _ImageSize(this.width, this.height);

  final int width;
  final int height;
}
