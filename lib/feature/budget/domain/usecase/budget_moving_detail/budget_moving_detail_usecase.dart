import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class BudgetMovingDetailUseCase {
  final BudgetRepository _repository;
  BudgetMovingDetailUseCase(this._repository);

  Future<Either<Failure, BudgetMovingDetailModel>> call() async {
    return await _repository.getBudgetMovingDetail();
  }
}
