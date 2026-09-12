import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/data/services/image_service.dart';
import 'package:store_app/core/domain/usecases/usecase.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:store_app/features/profile/presentation/bloc/profile_state.dart';

import '../../../products/domain/entity/app_image_entity.dart';
import '../../../products/domain/usecases/upload_image_usecase.dart';
import '../../domain/usecases/create_profile_usecase.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._getUserProfileUseCase,
    this._createProfileUseCase,
    this._uploadImageUseCase,
  ) : super(const ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      await event.map(
        createProfileRequested: (e) => _onCreateProfileRequested(e, emit),
        userProfileRequested: (e) => _onUserProfileRequested(e, emit),
        disableErrorRequested: (e) => _onErrorDisabled(e, emit),
        disableSuccessRequested: (e) => _onSuccessDisabled(e, emit),
        imagePicked: (e) => _onImagePicked(e, emit),
        imageRemoved: (e) => _onImageRemoved(e, emit),
      );
    });
  }

  final CreateProfileUseCase _createProfileUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UploadImageUseCase _uploadImageUseCase;

  Future<void> _onCreateProfileRequested(
    CreateProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.avatar == null) {
      emit(state.copyWith(error: 'createProfileScreen.addAvatar'.tr()));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final imageResult = await _uploadImageUseCase(
      UploadImageParams(image: state.avatar!),
    );

    final image = imageResult.fold((failure) {
      emit(state.copyWith(error: 'errors.serverError'.tr(), isLoading: false));

      return null;
    }, (image) => image);

    if (image == null) return;

    final result = await _createProfileUseCase(
      CreateProfileParams(
        userName: event.name,
        email: event.email,
        password: event.password,
        role: event.role,
        avatarUrl: image.location,
      ),
    );

    result.fold(
      (failure) {
        String message = 'errors.serverError'.tr();

        if (failure is InvalidCredentialsFailure) {
          message = 'errors.accessTokenInvalid'.tr();
        } else if (failure is UnknownFailure &&
            failure.message?.isNotEmpty == true) {
          message = failure.message!;
        }

        emit(state.copyWith(error: message, isLoading: false));
      },
      (profile) {
        emit(state.copyWith(createdSuccessful: profile, isLoading: false));
      },
    );
  }

  Future<void> _onUserProfileRequested(
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

  Future<void> _onImagePicked(
    ImagePicked event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.isAvatarLoading) return;
    AppImageEntity? avatar;

    emit(state.copyWith(isAvatarLoading: true));
    if (event.bytes != null) {
      avatar = await ImageService.processCameraImage(event.bytes!);
    } else {
      avatar = await ImageService.getImageFromGallery();
    }

    if (avatar != null) {
      emit(state.copyWith(avatar: avatar, isAvatarLoading: false));
    } else {
      emit(state.copyWith(isAvatarLoading: false));
      return;
    }
  }

  /// Remove selected image from the memory
  Future<void> _onImageRemoved(
    ImageRemoved event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(avatar: null));
  }

  Future<void> _onErrorDisabled(
    DisableErrorRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(error: null));
  }

  Future<void> _onSuccessDisabled(
    DisableSuccessRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        createdSuccessful: false,
        updatedSuccessful: false,
        avatar: null,
      ),
    );
  }
}
