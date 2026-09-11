import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/core/presentation/widgets/text_fields/email_text_field.dart';
import 'package:store_app/core/presentation/widgets/text_fields/password_field.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:store_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:store_app/features/login/presentation/bloc/login_event.dart';
import 'package:store_app/features/login/presentation/bloc/login_state.dart';
import 'package:store_app/features/login/presentation/pages/login_page.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

class FakeLoginState extends Fake implements LoginState {}

class FakeLoginEvent extends Fake implements LoginEvent {}

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeLoginEvent());
    registerFallbackValue(FakeLoginState());
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  late MockLoginBloc mockBloc;
  late MockAuthBloc authBloc;

  Widget createWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      startLocale: const Locale('en'),
      path: 'assets/translations/en.json',
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<LoginBloc>.value(value: mockBloc),
          ],
          child: const LoginPage(),
        ),
      ),
    );
  }

  setUp(() {
    mockBloc = MockLoginBloc();
    authBloc = MockAuthBloc();

    // AuthBloc
    when(() => authBloc.state).thenReturn(const AuthState());

    when(
      () => authBloc.stream,
    ).thenAnswer((_) => const Stream<AuthState>.empty());

    // LoginBloc
    when(
      () => mockBloc.state,
    ).thenReturn(const LoginState(status: LoginStatus.success));

    whenListen(
      mockBloc,
      Stream<LoginState>.fromIterable([
        const LoginState(status: LoginStatus.success),
      ]),
    );
  });

  group('LoginPage Tests', () {
    testWidgets('LoginPage renders correctly', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('LoginPage has email and password fields', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(EmailTextField), findsNWidgets(1));
      expect(find.byType(PasswordTextField), findsNWidgets(1));
    });

    testWidgets('LoginPage has login button', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Shows loader inside button when loading', (tester) async {
      when(
        () => mockBloc.state,
      ).thenReturn(const LoginState(status: LoginStatus.inProgress, error: ''));

      whenListen(
        mockBloc,
        Stream<LoginState>.value(
          const LoginState(status: LoginStatus.inProgress, error: ''),
        ),
        initialState: const LoginState(
          status: LoginStatus.inProgress,
          error: '',
        ),
      );

      await tester.pumpWidget(createWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Login with valid data triggers LoginLoginRequested', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      // Enter email
      await tester.enterText(
        find.byType(EmailTextField).at(0),
        'john@mail.com',
      );

      // Enter пароль
      await tester.enterText(find.byType(PasswordTextField).at(0), 'changeme');

      // Push the button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Check that event is sent
      verify(
        () => mockBloc.add(
          any(
            that: isA<LoginRequested>()
                .having((e) => e.email, 'email', 'john@mail.com')
                .having((e) => e.password, 'password', 'changeme'),
          ),
        ),
      ).called(1);
    });
  });
}
