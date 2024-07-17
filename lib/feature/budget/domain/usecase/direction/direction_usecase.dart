import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class DirectionUseCase implements UseCase<Directions, DirectionEntities> {
  final BudgetRepository _repository;
  DirectionUseCase(this._repository);

  @override
  Future<Either<Failure, Directions>> call(
      DirectionEntities directionEntities) async {
    return await _repository.getDirection(directionEntities);
  }
}
