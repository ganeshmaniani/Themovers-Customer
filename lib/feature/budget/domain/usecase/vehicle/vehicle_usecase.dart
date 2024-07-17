import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class VehicleTypeUseCase {
  final BudgetRepository _repository;
  VehicleTypeUseCase(this._repository);

  Future<Either<Failure, VehicleTypeModel>> call() async {
    return await _repository.getVehicleType();
  }
}
