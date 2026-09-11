import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_state.dart';

import '../../domain/usecases/get_user_profile_usecase.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._getUserProfileUseCase) : super(const ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      await event.map(
        userProfileRequested: (e) => _onProfileUserProfileRequested(e, emit),
      );
    });
  }

  final GetUserProfileUseCase _getUserProfileUseCase;

  Future<void> _onProfileUserProfileRequested(
    UserProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getUserProfileUseCase(NoParams());
    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.accessTokenInvalid'.tr();
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        emit(state.copyWith(user: r, isLoading: false));
      },
    );
  }
}
