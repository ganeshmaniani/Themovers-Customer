import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../tumpang/tumpang.dart';

final tumpangBookingUseCaseProvider = Provider<TumpangBookingUseCase>((ref) {
  final authRepository = ref.watch(tumpangRepositoryProvider);
  return TumpangBookingUseCase(authRepository);
});
