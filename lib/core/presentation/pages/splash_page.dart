import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/constants/app_strings.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../app/utils/utils.dart';
import '../../../features/auth/presentation/bloc/auth_event.dart';
import '../widgets/infinite_scroll_background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthBloc authBloc;
  bool _imagesReady = false;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppUtils.precacheImages(
        context,
        images: [AppStrings.wall, AppStrings.cart],
        onDone: () {
          setState(() {
            _imagesReady = true;
          });
        },
      );
      Future.delayed(const Duration(seconds: 2), () {
        authBloc.add(const AuthCheckRequested());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _imagesReady
          ? const Center(
              child: InfiniteScrollingBackground(
                animationHeight: 250.0,
                foregroundImageSize: 160.0,
                backgroundImage: AppStrings.wall,
                foregroundImage: AppStrings.cart,
              ),
            )
          : const SizedBox(),
    );
  }
}
