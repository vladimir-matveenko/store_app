import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/location_entity.dart';

class SelectedLocationItem extends StatelessWidget {
  const SelectedLocationItem({
    super.key,
    required this.location,
    required this.onTap,
  });

  final LocationEntity location;
  final Function(LocationEntity) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return GestureDetector(
      onTap: () {
        onTap(location);
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: theme.bottomNavigationBarTheme.backgroundColor,
        ),
        child: Column(
          spacing: 8.0,
          mainAxisSize: .min,
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .start,
              spacing: 8.0,
              children: [
                Icon(
                  Icons.location_pin,
                  color: theme.colorScheme.primary,
                  size: 24.0,
                ),
                Flexible(
                  child: Text(
                    location.name,
                    style: textTheme.titleMedium,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            Text(
              location.description,
              style: textTheme.bodyMedium,
              softWrap: true,
            ),
            Text(
              '${'locationsScreen.latitude'.tr()} ${location.latitude},',
              style: textTheme.bodyMedium,
              softWrap: true,
            ),
            Text(
              '${'locationsScreen.longitude'.tr()} ${location.longitude}',
              style: textTheme.bodyMedium,
              softWrap: true,
            ),
            if (location.distance != null)
              Text(
                '${location.distance}${'locationsScreen.kmFromYou'.tr()}',
                style: textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
