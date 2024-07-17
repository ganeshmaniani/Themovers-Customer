import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../budget/budget.dart';

final bookingUseCaseProvider = Provider<BookingUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return BookingUseCase(authRepository);
});
