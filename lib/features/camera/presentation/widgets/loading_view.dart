import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_loader.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: const Center(child: AppLoader()),
    );
  }
}
