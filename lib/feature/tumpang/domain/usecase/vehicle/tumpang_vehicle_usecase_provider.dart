import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../tumpang/tumpang.dart';

final tumpangVehicleTypeUseCaseProvider =
    Provider<TumpangVehicleTypeUseCase>((ref) {
  final authRepository = ref.watch(tumpangRepositoryProvider);
  return TumpangVehicleTypeUseCase(authRepository);
});
