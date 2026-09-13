import 'package:flutter/material.dart';
import 'package:store_app/features/products/domain/entity/app_image_entity.dart';

import '../../../../core/presentation/widgets/app_loader.dart';

class CreateProfileAvatar extends StatelessWidget {
  const CreateProfileAvatar({
    super.key,
    this.image,
    required this.onTap,
    this.onDeleteTap,
    this.showLoader = false,
    this.currentAvatar,
    this.avatarSize = 120.0,
  });

  final AppImageEntity? image;
  final VoidCallback onTap;
  final VoidCallback? onDeleteTap;
  final bool showLoader;
  final Widget? currentAvatar;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholder = ColoredBox(
      color: theme.unselectedWidgetColor,
      child: const Icon(Icons.add_photo_alternate_outlined, size: 32.0),
    );
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: avatarSize + 20.0,
        height: avatarSize,
        child: Stack(
          alignment: .center,
          children: [
            SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: ClipOval(
                child: image != null
                    ? Image.memory(
                        image!.bytes,
                        fit: .cover,
                        errorBuilder: (context, o, s) => placeholder,
                      )
                    : currentAvatar ?? placeholder,
              ),
            ),
            if (showLoader) const AppLoader(),
            if (onDeleteTap != null && image != null)
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  behavior: .translucent,
                  onTap: onDeleteTap,
                  child: Icon(
                    Icons.close,
                    color: theme.colorScheme.error,
                    size: 24.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
