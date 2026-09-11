import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/features/users/domain/repository/users_repository.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';

@lazySingleton
class CreateProfileUseCase implements UseCase<bool, CreateProfileParams> {
  CreateProfileUseCase(this._repository);

  final UsersRepository _repository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    return await _repository.createUser(
      name: params.userName,
      email: params.email,
      password: params.password,
      role: params.role,
      avatarUrl: params.avatarUrl,
    );
  }
}

class CreateProfileParams {
  CreateProfileParams({
    required this.userName,
    required this.email,
    required this.password,
    required this.role,
    required this.avatarUrl,
  });

  final String userName;
  final String email;
  final String password;
  final String role;
  final String avatarUrl;
}
