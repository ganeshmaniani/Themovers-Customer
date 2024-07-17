import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../tumpang/tumpang.dart';

final tumpangPlaceToGeocodeUseCaseProvider =
    Provider<TumpangPlaceToGeocodeUseCase>((ref) {
  final authRepository = ref.watch(tumpangRepositoryProvider);
  return TumpangPlaceToGeocodeUseCase(authRepository);
});
