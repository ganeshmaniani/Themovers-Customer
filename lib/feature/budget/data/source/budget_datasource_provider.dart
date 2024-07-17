import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../budget/budget.dart';

final budgetDatasourceProvider = Provider<BudgetDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return BudgetDataSourceImpl(apiServices);
});
