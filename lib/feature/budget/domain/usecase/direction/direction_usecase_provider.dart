import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../budget/budget.dart';

final directionUseCaseProvider = Provider<DirectionUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return DirectionUseCase(authRepository);
});
