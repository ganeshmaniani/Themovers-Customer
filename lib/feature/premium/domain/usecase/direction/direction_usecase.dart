import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../premium.dart';

class PremiumDirectionUseCase
    implements UseCase<PremiumDirections, PremiumDirectionEntities> {
  final PremiumRepository _repository;
  PremiumDirectionUseCase(this._repository);

  @override
  Future<Either<Failure, PremiumDirections>> call(
      PremiumDirectionEntities directionEntities) async {
    return await _repository.getDirection(directionEntities);
  }
}
