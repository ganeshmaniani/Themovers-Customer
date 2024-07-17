import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class BookingUseCase implements UseCase<dynamic, BudgetEntities> {
  final BudgetRepository _repository;
  BookingUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(BudgetEntities budgetEntities) async {
    return await _repository.budgetBooking(budgetEntities);
  }
}
