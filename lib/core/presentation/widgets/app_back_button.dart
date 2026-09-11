import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed:
          onTap ??
          () {
            if (context.canPop()) {
              context.pop();
            }
          },
    );
  }
}
