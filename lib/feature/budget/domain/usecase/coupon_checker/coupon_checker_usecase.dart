import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/budget/domain/entities/coupon_code_checker_entities.dart';

import '../../repositories/budget_repositories.dart';

class CouponCodeCheckerUseCase
    implements UseCase<dynamic, CouponCodeCheckerEntities> {
  final BudgetRepository _budgetRepository;

  CouponCodeCheckerUseCase(this._budgetRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      CouponCodeCheckerEntities couponCodeCheckerEntities) async {
    return await _budgetRepository.coupanCodeChecker(couponCodeCheckerEntities);
  }
}
