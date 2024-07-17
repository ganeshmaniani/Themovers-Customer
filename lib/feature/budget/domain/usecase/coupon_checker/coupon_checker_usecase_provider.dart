import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/budget/budget.dart';
import 'package:themovers/feature/budget/domain/usecase/coupon_checker/coupon_checker_usecase.dart';

final couponCodeCheckerUseCaseProvider =
    Provider<CouponCodeCheckerUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return CouponCodeCheckerUseCase(authRepository);
});
