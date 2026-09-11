import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/domain/entity/availability_filter_entity.dart';
import 'package:store_app/features/products/domain/entity/category_entity.dart';

import '../../app/constants/app_strings.dart';

@immutable
class ProductsUtils {
  const ProductsUtils._();

  static Widget getFilterButton(
    BuildContext context, {
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor:
            Theme.of(
              context,
            ).iconButtonTheme.style?.backgroundColor?.resolve({}) ??
            Colors.grey,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      onPressed: onTap,
      icon: Icon(
        isActive ? Icons.filter_alt : Icons.filter_alt_outlined,
        color: isActive ? Colors.blue : Colors.white,
        size: 24.0,
      ),
    );
  }

  static Widget getSearchCategoryButton(
    BuildContext context, {
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: IconButton(
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor:
              Theme.of(
                context,
              ).iconButtonTheme.style?.backgroundColor?.resolve({}) ??
              Colors.grey,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: onTap,
        icon: Icon(
          isActive ? Icons.search_off_outlined : Icons.search_outlined,
          color: theme.colorScheme.onPrimary,
          size: 16.0,
        ),
      ),
    );
  }

  static bool isBottom(ScrollController scrollController) {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  static (int?, int?) getPriceFilters(List<AvailabilityFilterEntity> filters) {
    final priceMin = filters
        .firstWhereOrNull((e) => e.identifier == AppStrings.amountMin)
        ?.apiValue;

    final priceMax = filters
        .firstWhereOrNull((e) => e.identifier == AppStrings.amountMax)
        ?.apiValue;

    return (priceMin, priceMax);
  }

  static List<CategoryEntity> filterCategoriesBySearchTerm(
    List<CategoryEntity> categories,
    String? searchTerm,
  ) {
    if (searchTerm == null || searchTerm.isEmpty) {
      return categories;
    }
    final term = searchTerm.toLowerCase();
    return categories
        .where((category) => category.name.toLowerCase().contains(term))
        .toList();
  }
}
