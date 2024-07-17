import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../budget/budget.dart';

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  final remoteDataSource = ref.watch(budgetDatasourceProvider);
  return BudgetRepositoryImpl(remoteDataSource);
});
