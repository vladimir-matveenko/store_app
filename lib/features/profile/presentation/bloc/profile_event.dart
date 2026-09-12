import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../products/domain/entity/app_image_entity.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.userProfileRequested() = UserProfileRequested;

  const factory ProfileEvent.createProfileRequested({
    required String name,
    required String email,
    required String password,
    required String role,
    required String avatarUrl,
  }) = CreateProfileRequested;

  const factory ProfileEvent.imagePicked({Uint8List? bytes}) = ImagePicked;

  const factory ProfileEvent.imageRemoved({required AppImageEntity image}) =
      ImageRemoved;

  const factory ProfileEvent.disableSuccessRequested() =
      DisableSuccessRequested;

  const factory ProfileEvent.disableErrorRequested() = DisableErrorRequested;
}
