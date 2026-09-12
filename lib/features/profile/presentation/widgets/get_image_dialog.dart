import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/pages.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';

class GetImageDialog extends StatelessWidget {
  const GetImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return Padding(
      padding: const .all(24.0),
      child: Column(
        spacing: 16.0,
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              context.pop();
              final bytes = await context.push<Uint8List>(Pages.camera);

              if (bytes != null) {
                bloc.add(ImagePicked(bytes: bytes));
              }
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
              bloc.add(const ImagePicked());
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
