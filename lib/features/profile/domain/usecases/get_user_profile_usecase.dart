import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/domain/usecases/usecase.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/features/profile/domain/repository/profile_repository.dart';

import '../entity/user_entity.dart';

@lazySingleton
class GetUserProfileUseCase implements UseCase<UserEntity?, NoParams> {
  GetUserProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}
