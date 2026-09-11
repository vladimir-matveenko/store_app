import 'package:dartz/dartz.dart';
import 'package:store_app/core/error/failure.dart';

import '../entity/user_entity.dart';

abstract class ProfileRepository {
  UserEntity? get profile;

  Either<Failure, void> clearCache();

  Future<Either<Failure, UserEntity?>> getUserProfile();
}
