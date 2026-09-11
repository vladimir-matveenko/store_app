import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/domain/usecases/usecase.dart';

@lazySingleton
class CheckAuthUseCase implements UseCase<bool, NoParams> {
  CheckAuthUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isAuthenticated();
  }
}
