import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../budget/budget.dart';

final longPushTypeUseCaseProvider = Provider<LongPushTypeUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return LongPushTypeUseCase(authRepository);
});
