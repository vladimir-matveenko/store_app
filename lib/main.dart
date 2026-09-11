import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/app/constants/app_strings.dart';

import 'app/di/injection.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: AppStrings.assetTranslationsPath,
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}
