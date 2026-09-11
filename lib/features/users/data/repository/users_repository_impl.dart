import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/error/mapper.dart';

import '../../../profile/data/models/user_model.dart';
import '../../../profile/domain/entity/user_entity.dart';
import '../../domain/repository/users_repository.dart';
import '../data_sources/users_remote_data_source.dart';

@LazySingleton(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl({required this.usersRemoteDataSource});

  final UsersRemoteDataSource usersRemoteDataSource;

  @override
  Future<Either<Failure, List<UserEntity>>> fetchUsers() async {
    try {
      final users = await usersRemoteDataSource.fetchUsers();
      final list = users?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> fetchUser({String? id}) async {
    try {
      final user = await usersRemoteDataSource.fetchUser(id: id);
      return Right(user!.toEntity());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
    required String avatarUrl,
  }) async {
    try {
      final user = await usersRemoteDataSource.createUser(
        name: name,
        email: email,
        password: password,
        role: role,
        avatarUrl: avatarUrl,
      );
      return Right(user != null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
