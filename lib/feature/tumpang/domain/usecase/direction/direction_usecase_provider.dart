import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../tumpang/tumpang.dart';

final tumpangDirectionUseCaseProvider =
    Provider<TumpangDirectionUseCase>((ref) {
  final authRepository = ref.watch(tumpangRepositoryProvider);
  return TumpangDirectionUseCase(authRepository);
});
