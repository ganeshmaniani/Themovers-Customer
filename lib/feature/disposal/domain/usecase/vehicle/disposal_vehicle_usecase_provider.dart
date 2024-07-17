import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../disposal/disposal.dart';

final disposalVehicleTypeUseCaseProvider =
    Provider<DisposalVehicleTypeUseCase>((ref) {
  final authRepository = ref.watch(disposalRepositoryProvider);
  return DisposalVehicleTypeUseCase(authRepository);
});
