import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../budget/budget.dart';

final vehicleTypeUseCaseProvider = Provider<VehicleTypeUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return VehicleTypeUseCase(authRepository);
});
