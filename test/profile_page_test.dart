import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/core/presentation/widgets/user_avatar.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:store_app/features/profile/domain/entity/user_entity.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:store_app/features/profile/presentation/pages/profile_page.dart';
import 'package:store_app/features/profile/presentation/widgets/language_selector.dart';
import 'package:store_app/features/profile/presentation/widgets/theme_selector.dart';
import 'package:store_app/features/theme/cubit/cubit.dart';
import 'package:store_app/features/theme/cubit/state.dart';

// Mocks
class MockAuthBloc extends Mock implements AuthBloc {}

class MockProfileBloc extends Mock implements ProfileBloc {}

class MockThemeCubit extends Mock implements ThemeCubit {}

class FakeProfileState extends Fake implements ProfileState {}

class FakeThemeState extends Fake implements ThemeState {}

class FakeAuthState extends Fake implements AuthState {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class ProfileEventFake extends Fake implements ProfileEvent {}

void main() {
  late AuthBloc authBloc;
  late ProfileBloc profileBloc;
  late ThemeCubit themeCubit;
  late StreamController<ProfileState> profileController;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeProfileState());
    registerFallbackValue(ProfileEventFake());
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeThemeState());
    registerFallbackValue(FakeAuthEvent());
  });

  setUp(() {
    authBloc = MockAuthBloc();
    profileBloc = MockProfileBloc();
    themeCubit = MockThemeCubit();

    profileController = StreamController<ProfileState>.broadcast();
  });

  tearDown(() async {
    await profileController.close();
  });

  group('ProfilePage Tests', () {
    testWidgets('ProfilePage displays user info and logout button', (
      WidgetTester tester,
    ) async {
      final userState = const ProfileState(
        user: UserEntity(
          id: '1',
          name: 'Jhon',
          email: 'john@mail.com',
          avatar: 'https://api.lorem.space/image/face?w=640&h=480&r=867',
          role: 'customer',
        ),
      );

      // AuthBloc
      when(() => authBloc.state).thenReturn(const AuthState());
      when(
        () => authBloc.stream,
      ).thenAnswer((_) => const Stream<AuthState>.empty());

      // ProfileBloc
      when(() => profileBloc.state).thenReturn(userState);
      when(
        () => profileBloc.stream,
      ).thenAnswer((_) => profileController.stream);

      // ThemeCubit
      when(() => themeCubit.state).thenReturn(const ThemeState());
      when(
        () => themeCubit.stream,
      ).thenAnswer((_) => const Stream<ThemeState>.empty());

      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<ProfileBloc>.value(value: profileBloc),
            BlocProvider<ThemeCubit>.value(value: themeCubit),
          ],
          child: EasyLocalization(
            supportedLocales: const [Locale('en')],
            startLocale: const Locale('en'),
            path: 'assets/translations/en.json',
            fallbackLocale: const Locale('en'),
            child: const MaterialApp(home: Scaffold(body: ProfilePage())),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // User info
      expect(find.byType(UserAvatar), findsOneWidget);
      expect(find.text('Jhon'), findsOneWidget);
      expect(find.textContaining('john@mail.com'), findsOneWidget);

      // Selectors
      expect(find.byType(ThemeSelector), findsOneWidget);
      expect(find.byType(LanguageSelector), findsOneWidget);

      // Logout button
      final logoutButton = find.byIcon(Icons.logout);
      expect(logoutButton, findsOneWidget);

      await tester.tap(logoutButton);
      await tester.pump();

      verify(() => authBloc.add(any(that: isA<LogoutRequested>()))).called(1);

      await tester.binding.setSurfaceSize(null);
    });
  });
}
