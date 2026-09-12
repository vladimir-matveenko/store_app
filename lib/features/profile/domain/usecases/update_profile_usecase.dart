import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/features/profile/domain/repository/profile_repository.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';

@lazySingleton
class UpdateProfileUseCase implements UseCase<bool, UpdateProfileParams> {
  UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    return await _repository.updateProfile(
      userId: params.userId,
      name: params.userName,
      email: params.email,
      password: params.password,
      role: params.role,
      avatarUrl: params.avatarUrl,
    );
  }
}

class UpdateProfileParams {
  UpdateProfileParams({
    required this.userId,
    this.userName,
    this.email,
    this.password,
    this.role,
    this.avatarUrl,
  });

  final int userId;
  final String? userName;
  final String? email;
  final String? password;
  final String? role;
  final String? avatarUrl;
}
