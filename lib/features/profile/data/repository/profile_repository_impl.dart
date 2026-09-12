import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/error/mapper.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';
import '../models/user_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required this.dataSource});

  final ProfileRemoteDataSource dataSource;
  UserEntity? _profile;

  @override
  UserEntity? get profile => _profile;

  @override
  Future<Either<Failure, UserEntity?>> getUserProfile() async {
    try {
      final user = await dataSource.getProfile();
      if (user == null) {
        return Left(UnknownFailure());
      }
      _profile = user.toEntity();
      return Right(_profile);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Either<Failure, void> clearCache() {
    try {
      _profile = null;
      return const Right(null);
    } on Exception catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfile({
    required int userId,
    String? name,
    String? email,
    String? password,
    String? role,
    String? avatarUrl,
  }) async {
    try {
      final user = await dataSource.updateProfile(
        userId: userId,
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
