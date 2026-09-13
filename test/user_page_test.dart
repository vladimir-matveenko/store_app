import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/app/constants/app_enums.dart';
import 'package:store_app/core/presentation/widgets/app_loader.dart';
import 'package:store_app/core/presentation/widgets/user_avatar.dart';
import 'package:store_app/features/profile/domain/entity/user_entity.dart';
import 'package:store_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:store_app/features/users/presentation/bloc/users_event.dart';
import 'package:store_app/features/users/presentation/bloc/users_state.dart';
import 'package:store_app/features/users/presentation/pages/user_page.dart';

// Mocks
class MockUsersBloc extends Mock implements UsersBloc {}

class FakeUsersState extends Fake implements UsersState {}

class FakeUsersEvent extends Fake implements UsersEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeUsersState());
    registerFallbackValue(FakeUsersEvent());
  });

  late MockUsersBloc usersBloc;
  late StreamController<UsersState> usersController;

  setUp(() {
    usersBloc = MockUsersBloc();
    usersController = StreamController<UsersState>.broadcast();
  });

  tearDown(() {
    usersController.close();
  });

  Widget createWidget({required String userId}) {
    return MaterialApp(
      home: BlocProvider<UsersBloc>.value(
        value: usersBloc,
        child: UserPage(id: userId),
      ),
    );
  }

  group('UserPage Tests', () {
    testWidgets('UserPage shows loading indicator when loading', (
      tester,
    ) async {
      when(
        () => usersBloc.state,
      ).thenReturn(const UsersState(isUserLoading: true));
      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);

      await tester.pumpWidget(createWidget(userId: '1'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('UserPage displays user information when data is available', (
      tester,
    ) async {
      final user = const UserEntity(
        id: 1,
        email: 'john@example.com',
        password: 'changeme',
        name: 'John Doe',
        role: UserRole.admin,
        avatar: '',
      );

      when(
        () => usersBloc.state,
      ).thenReturn(const UsersState(isUserLoading: true));

      when(() => usersBloc.stream).thenAnswer((_) => usersController.stream);

      await tester.pumpWidget(createWidget(userId: '1'));

      // Initial state.
      expect(find.byType(AppLoader), findsOneWidget);

      // UsersBloc has loaded the user.
      usersController.add(UsersState(user: user));

      // Process the emitted state and the setState from precaching.
      await tester.pump();

      expect(find.byType(UserAvatar), findsOneWidget);

      expect(find.text(user.email), findsOneWidget);
      expect(find.text(user.name), findsOneWidget);
      expect(find.text(user.role.name), findsOneWidget);
    });
  });
}
