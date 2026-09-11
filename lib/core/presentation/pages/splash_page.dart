import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/app/constants/app_strings.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_event.dart';

import '../widgets/infinite_scroll_background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        authBloc.add(const AuthCheckRequested());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
