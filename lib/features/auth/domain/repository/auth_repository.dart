import 'package:dartz/dartz.dart';
import 'package:store_app/core/error/failure.dart';

import '../entity/auth_token_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, bool>> isAuthenticated();
}
