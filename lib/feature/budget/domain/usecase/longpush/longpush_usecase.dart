import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class LongPushTypeUseCase {
  final BudgetRepository _repository;
  LongPushTypeUseCase(this._repository);

  Future<Either<Failure, LongpushTypeModel>> call() async {
    return await _repository.getLongPushType();
  }
}
