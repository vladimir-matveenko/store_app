import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/presentation/widgets/avatar_placeholder.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatar,
    this.size = 80.0,
    this.firstName,
    this.lastName,
  });

  final String avatar;
  final String? firstName;
  final String? lastName;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      key: ValueKey(avatar),
      radius: size / 2,
      backgroundImage: CachedNetworkImageProvider(avatar),
      backgroundColor: theme.colorScheme.surfaceTint,
      onBackgroundImageError: (o, s) => AvatarPlaceholder(
        backgroundColor: theme.unselectedWidgetColor,
        firstName: firstName ?? '',
        lastName: lastName ?? '',
      ),
    );
  }
}
