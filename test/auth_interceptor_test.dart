import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/core/network/http_interceptors.dart';
import 'package:store_app/core/services/auth_session_manager.dart';
import 'package:store_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:store_app/features/auth/data/models/auth_token_model.dart';

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockAuthSessionManager extends Mock implements AuthSessionManager {}

class MockDio extends Mock implements Dio {}

class FakeAuthTokenModel extends Fake implements AuthTokenModel {}

void main() {
  late MockAuthLocalDataSource localDataSource;
  late MockAuthSessionManager sessionManager;
  late MockDio refreshDio;
  late AuthInterceptor interceptor;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(FakeAuthTokenModel());
  });

  setUp(() {
    localDataSource = MockAuthLocalDataSource();
    sessionManager = MockAuthSessionManager();
    refreshDio = MockDio();

    interceptor = AuthInterceptor(localDataSource, sessionManager, refreshDio);
  });

  group('AuthInterceptor', () {
    test('refresh token success', () async {
      when(() => localDataSource.getCachedToken()).thenAnswer(
        (_) async =>
            const AuthTokenModel(accessToken: 'old', refreshToken: 'refresh'),
      );

      when(() => localDataSource.cacheToken(any())).thenAnswer((_) async {});

      when(
        () => refreshDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: 'auth/refresh-token'),
          data: {'access_token': 'new_access', 'refresh_token': 'new_refresh'},
        ),
      );

      when(() => refreshDio.fetch(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/products'),
          statusCode: 200,
        ),
      );

      await interceptor.onError(
        DioException(
          requestOptions: RequestOptions(path: '/products'),
          response: Response(
            requestOptions: RequestOptions(path: '/products'),
            statusCode: 401,
          ),
        ),
        _NoopHandler(),
      );

      verify(
        () => refreshDio.post(
          'auth/refresh-token',
          data: {'refreshToken': 'refresh'},
          options: any(named: 'options'),
        ),
      ).called(1);

      verify(() => localDataSource.cacheToken(any())).called(1);

      verifyNever(() => sessionManager.notifySessionExpired());
    });

    test('refresh token invalid → logout', () async {
      when(() => localDataSource.getCachedToken()).thenAnswer(
        (_) async =>
            const AuthTokenModel(accessToken: 'old', refreshToken: 'bad'),
      );

      when(
        () => refreshDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'auth/refresh-token'),
          response: Response(
            requestOptions: RequestOptions(path: 'auth/refresh-token'),
            statusCode: 401,
          ),
        ),
      );

      await interceptor.onError(
        DioException(
          requestOptions: RequestOptions(path: '/products'),
          response: Response(
            requestOptions: RequestOptions(path: '/products'),
            statusCode: 401,
          ),
        ),
        _NoopHandler(),
      );

      verify(() => sessionManager.notifySessionExpired()).called(1);
    });

    test('missing refresh token → logout', () async {
      when(
        () => localDataSource.getCachedToken(),
      ).thenAnswer((_) async => null);

      await interceptor.onError(
        DioException(
          requestOptions: RequestOptions(path: '/products'),
          response: Response(
            requestOptions: RequestOptions(path: '/products'),
            statusCode: 401,
          ),
        ),
        _NoopHandler(),
      );

      verify(() => sessionManager.notifySessionExpired()).called(1);
    });
  });
}

class _NoopHandler extends ErrorInterceptorHandler {
  @override
  void next(DioException err) {}

  @override
  void resolve(Response response) {}

  @override
  void reject(DioException err, {bool callFollowingErrorInterceptor = false}) {}
}
