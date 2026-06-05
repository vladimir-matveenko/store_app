import 'package:flutter/material.dart';
import 'package:store_app/core/constants/app_strings.dart';

import '../../../../core/presentation/widgets/infinite_scroll_background.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InfiniteScrollingBackground(
          animationHeight: 250.0,
          foregroundImageSize: 160.0,
          backgroundImage: AppStrings.wall,
          foregroundImage: AppStrings.cart,
        ),
      ),
    );
  }
}
