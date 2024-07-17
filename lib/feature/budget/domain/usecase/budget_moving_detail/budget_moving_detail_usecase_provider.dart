import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../budget/budget.dart';

final budgetMovingDetailUseCaseProvider =
    Provider<BudgetMovingDetailUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return BudgetMovingDetailUseCase(authRepository);
});
