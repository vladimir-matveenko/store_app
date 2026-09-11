import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../products/domain/entity/app_image_entity.dart';
import '../../domain/entity/user_entity.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool isAvatarLoading,
    @Default(false) bool createdSuccessful,
    @Default(false) bool updatedSuccessful,
    UserEntity? user,
    String? error,
    AppImageEntity? avatar,
  }) = _ProfileState;
}
