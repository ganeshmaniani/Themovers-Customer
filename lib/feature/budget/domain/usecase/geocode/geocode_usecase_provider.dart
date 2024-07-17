import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../budget/budget.dart';

final placeToGeocodeUseCaseProvider = Provider<PlaceToGeocodeUseCase>((ref) {
  final authRepository = ref.watch(budgetRepositoryProvider);
  return PlaceToGeocodeUseCase(authRepository);
});
