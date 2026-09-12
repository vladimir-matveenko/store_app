import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_loader.dart';
import '../../../../core/presentation/widgets/user_avatar.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.avatarUrl,
    required this.userName,
    required this.onTap,
    this.showLoader = false,
  });

  final String avatarUrl;
  final String userName;
  final VoidCallback onTap;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: .center,
        children: [
          UserAvatar(
            size: 120.0,
            avatar: avatarUrl,
            firstName: userName,
            lastName: '',
          ),
          if (showLoader) const AppLoader(),
        ],
      ),
    );
  }
}
