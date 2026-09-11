import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';

import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@lazySingleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      await event.map(loginRequested: (e) => _onLoginRequested(e, emit));
    });
  }

  final LoginUseCase _loginUseCase;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.inProgress));

    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (l) {
        String message = 'errors.authError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        } else if (l is ServerFailure) {
          message = 'errors.serverError'.tr();
        }
        emit(state.copyWith(error: message, status: LoginStatus.failure));
      },
      (r) {
        emit(state.copyWith(status: LoginStatus.success));
      },
    );
  }
}
