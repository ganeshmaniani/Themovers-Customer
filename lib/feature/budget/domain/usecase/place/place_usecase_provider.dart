import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../budget/budget.dart';

final placeUseCaseProvider = Provider<PlaceUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return PlaceUseCase(authRepository);
});
