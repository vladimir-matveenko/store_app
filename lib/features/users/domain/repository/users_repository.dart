import 'package:dartz/dartz.dart';
import 'package:store_app/core/error/failure.dart';

import '../../../profile/domain/entity/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, bool>> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
    required String avatarUrl,
  });

  Future<Either<Failure, List<UserEntity>>> fetchUsers();

  Future<Either<Failure, UserEntity>> fetchUser({String? id});
}
