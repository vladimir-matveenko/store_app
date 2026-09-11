import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:store_app/features/profile/domain/entity/user_entity.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:store_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:store_app/features/users/presentation/bloc/users_event.dart';
import 'package:store_app/features/users/presentation/bloc/users_state.dart';
import 'package:store_app/features/users/presentation/pages/users_page.dart';
import 'package:store_app/features/users/presentation/widgets/users_list.dart';

class MockUsersBloc extends Mock implements UsersBloc {}

class MockAuthBloc extends Mock implements AuthBloc {}

class MockProfileBloc extends Mock implements ProfileBloc {}

class FakeUsersState extends Fake implements UsersState {}

class FakeAuthState extends Fake implements AuthState {}

class FakeProfileState extends Fake implements ProfileState {}

class FakeUsersEvent extends Fake implements UsersEvent {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeProfileEvent extends Fake implements ProfileEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeUsersState());
    registerFallbackValue(FakeUsersEvent());
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeProfileState());
    registerFallbackValue(FakeProfileEvent());
  });

  late MockUsersBloc usersBloc;
  late MockAuthBloc authBloc;
  late MockProfileBloc profileBloc;
  late StreamController<UsersState> usersController;
  late StreamController<AuthState> authController;
  late StreamController<ProfileState> profileController;

  setUp(() {
    usersBloc = MockUsersBloc();
    authBloc = MockAuthBloc();
    profileBloc = MockProfileBloc();
    usersController = StreamController<UsersState>.broadcast();
    authController = StreamController<AuthState>.broadcast();
    profileController = StreamController<ProfileState>.broadcast();
  });

  tearDown(() {
    usersController.close();
    authController.close();
    profileController.close();
  });

  Widget createWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      startLocale: const Locale('en'),
      path: 'assets/translations/en.json',
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<UsersBloc>.value(value: usersBloc),
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<ProfileBloc>.value(value: profileBloc),
          ],
          child: const UsersPage(),
        ),
      ),
    );
  }

  group('UsersPage Tests', () {
    testWidgets('UsersPage displays loading indicator when loading', (
      tester,
    ) async {
      when(() => usersBloc.state).thenReturn(const UsersState(isLoading: true));
      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);
      when(() => authBloc.state).thenReturn(const AuthState());
      when(() => authBloc.stream).thenAnswer((_) => authController.stream);

      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('UsersPage displays users list when data is available', (
      tester,
    ) async {
      final users = [
        const UserEntity(
          id: '1',
          email: 'user1@example.com',
          name: 'User One',
          role: 'admin',
          avatar: 'avatar1.jpg',
        ),
        const UserEntity(
          id: '2',
          email: 'user2@example.com',
          name: 'User Two',
          role: 'user',
          avatar: 'avatar2.jpg',
        ),
      ];

      when(
        () => usersBloc.state,
      ).thenReturn(UsersState(users: users, isInitialized: true));
      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);
      when(() => authBloc.state).thenReturn(const AuthState());
      when(() => authBloc.stream).thenAnswer((_) => authController.stream);
      when(() => profileBloc.state).thenReturn(const ProfileState());
      when(
        () => profileBloc.stream,
      ).thenAnswer((_) => profileController.stream);

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(UsersList), findsOneWidget);
      expect(find.text('User One'), findsOneWidget);
      expect(find.text('User Two'), findsOneWidget);
    });

    testWidgets('UsersPage triggers UsersFetched on init', (tester) async {
      when(() => usersBloc.state).thenReturn(const UsersState());
      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);
      when(() => authBloc.state).thenReturn(const AuthState());
      when(() => authBloc.stream).thenAnswer((_) => authController.stream);

      await tester.pumpWidget(createWidget());
      await tester.pump();

      verify(() => usersBloc.add(const UsersFetched())).called(1);
    });
  });
}
