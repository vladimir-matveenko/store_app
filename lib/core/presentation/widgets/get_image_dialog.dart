import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetImageDialog extends StatelessWidget {
  const GetImageDialog({
    super.key,
    required this.onCameraTapped,
    required this.onGalleryTapped,
  });

  final VoidCallback onCameraTapped;
  final VoidCallback onGalleryTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(24.0),
      child: Column(
        spacing: 16.0,
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.pop();
              onCameraTapped();
            },
            child: Row(
              spacing: 8.0,
              mainAxisAlignment: .center,
              children: [
                Text('createProfileScreen.imageSource.camera'.tr()),
                const Icon(Icons.camera_alt_outlined, size: 16.0),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.pop();
              onGalleryTapped();
            },
            child: Row(
              spacing: 8.0,
              mainAxisAlignment: .center,
              children: [
                Text('createProfileScreen.imageSource.gallery'.tr()),
                const Icon(Icons.image, size: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
