import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../tumpang.dart';

class TumpangDirectionUseCase
    implements UseCase<TumpangDirections, TumpangDirectionEntities> {
  final TumpangRepository _repository;
  TumpangDirectionUseCase(this._repository);

  @override
  Future<Either<Failure, TumpangDirections>> call(
      TumpangDirectionEntities directionEntities) async {
    return await _repository.getDirection(directionEntities);
  }
}
