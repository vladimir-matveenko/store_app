import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'errors.noItemsAvailable'.tr(),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
