import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/domain/usecases/usecase.dart';
import 'package:store_app/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:store_app/features/auth/presentation/bloc/auth_state.dart';

import '../../../profile/domain/usecases/clear_cache_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._checkAuthUseCase, this._logoutUseCase, this._clearCacheUseCase)
    : super(const AuthState()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        checkRequested: (e) => _onAuthCheckRequested(e, emit),
        logoutRequested: (e) => _onLogoutRequested(e, emit),
        clearCacheRequested: (e) => _onClearCacheRequested(e, emit),
      );
    });
  }

  final CheckAuthUseCase _checkAuthUseCase;
  final LogoutUseCase _logoutUseCase;
  final ClearCacheUseCase _clearCacheUseCase;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _checkAuthUseCase(NoParams());

    result.fold(
      (l) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
      (r) {
        if (r) {
          emit(state.copyWith(status: AuthStatus.authenticated));
        } else {
          emit(state.copyWith(status: AuthStatus.unauthenticated));
        }
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _logoutUseCase(NoParams());
    result.fold(
      (l) {
        String message = 'errors.logoutError'.tr();
        emit(
          state.copyWith(error: message, status: AuthStatus.unauthenticated),
        );
      },
      (r) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
    );
  }

  Future<void> _onClearCacheRequested(
    ClearCacheRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _clearCacheUseCase.call(NoParams());
    result.fold(
      (l) {
        String message = 'errors.unknownError'.tr();
        emit(
          state.copyWith(error: message, status: AuthStatus.unauthenticated),
        );
      },
      (r) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
    );
  }
}
