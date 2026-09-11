import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/profile_repository.dart';

@lazySingleton
class ClearCacheUseCase implements UseCase<void, NoParams> {
  ClearCacheUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return _repository.clearCache();
  }
}
